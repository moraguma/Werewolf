extends Node2D

class_name Game

# --------------------------------------------------------------------------------------------------
# CONSTANTS
# --------------------------------------------------------------------------------------------------
@onready var TRAIT_PRIORITY: Array[String] = [
	"Trait",
	"SinglePlayerSelection",
	"Example",
	TranslationManager.get_translation("healer_name"),
	TranslationManager.get_translation("serial_killer_name"),
	TranslationManager.get_translation("wolf_name")
]

# Visual -----------------------------------------------------------------------
const THEME = preload("res://resources/themes/game.tres")
var NIGHT_COLOR_SCHEME = ColorScheme.new(Color("#8a1471"), Color("#161b57"), Color("#cd3e44"), Color("#140918"), Color("#501c40"), Color("#f4e1fb"))
var DAY_COLOR_SCHEME = ColorScheme.new(Color("#1b7ccd"), Color("#fed9c9"), Color("#da6600"), Color("#1f0c00"), Color("#fee3c5"), Color("#100602"))

const SUN_SET_POS = Vector2(540, 1664)
const SUN_MIDDAY_POS = Vector2(540, 128)

# Scenes -----------------------------------------------------------------------
const LOG_SCENE = preload("res://scenes/Log.tscn")

# --------------------------------------------------------------------------------------------------
# VARIABLES
# --------------------------------------------------------------------------------------------------
var public_log: Array[Log] = []
var private_log: Array[Log] = []

var players: Array[Player] = []
var winners: Array[Winner] = []

var color_scheme: ColorScheme

# --------------------------------------------------------------------------------------------------
# NODES
# --------------------------------------------------------------------------------------------------
@onready var sky = $BG/Sky
@onready var sun = $BG/Sun
@onready var mountains = $BG/Mountains
@onready var screens = $Screens

# Night ------------------------------------------------------------------------
@onready var night_control = $Screens/Night
@onready var night_start = $Screens/Night/Start
@onready var night_present = $Screens/Night/Present
@onready var night_traits = $Screens/Night/Traits

# Day announcements ------------------------------------------------------------
@onready var announcements_control = $Screens/Announcements
@onready var announcements_next = $Screens/Announcements/Next

# Discussion -------------------------------------------------------------------
@onready var discussion_control = $Screens/Discussion

# Voting -----------------------------------------------------------------------
@onready var voting_control = $Screens/Voting
@onready var voting_start = $Screens/Voting/Start
@onready var voting_present = $Screens/Voting/Present
@onready var voting_vote = $Screens/Voting/Vote

# Victory ----------------------------------------------------------------------
@onready var victory = $Screens/Victory


func _ready():
	# Test setup
	var p1 = Player.new(preload("res://resources/sprites/players/Andre.png"), "André", ColorScheme.new(Color.AQUA, Color.AZURE, Color.BISQUE, Color.CHOCOLATE, Color.CRIMSON, Color.BLACK))
	var p2 = Player.new(preload("res://resources/sprites/players/Gustavo.png"), "Gustavo", ColorScheme.new(Color.AQUA, Color.AZURE, Color.BISQUE, Color.CHOCOLATE, Color.CRIMSON, Color.BLACK))
	var p3 = Player.new(preload("res://resources/sprites/players/Paulinho.png"), "Paulinho", ColorScheme.new(Color.AQUA, Color.AZURE, Color.BISQUE, Color.CHOCOLATE, Color.CRIMSON, Color.BLACK))
	
	p1.give_trait(HealerTrait.new())
	
	p2.give_trait(SerialKillerTrait.new())
	p2.give_trait(WolfTrait.new())
	
	p3.give_trait(HealerTrait.new())
	p3.give_trait(WolfTrait.new())
	
	players.append_array([p1, p2, p3])
	
	for player in players:
		player.set_game(self)
	
	for control in [night_control, announcements_control, discussion_control, voting_control]:
		control.theme = THEME
	color_scheme = NIGHT_COLOR_SCHEME
	color_scheme.set_colors(sky, sun, mountains)
	sun.position = SUN_SET_POS
	
	
	game_loop()


func _process(_delta):
	color_scheme.update_colors(sky, sun, mountains)

func game_loop():
	var phases: Array[Callable] = [
		night,
		discussion,
	]
	
	var pos = 0
	while winners == [] and len(get_alive_players()) > 1:
		await phases[pos].call()
		pos = 0 if pos + 1 >= len(phases) else pos + 1
	
	show_winners()


func night():
	screens.set_phase("NIGHT")
	sun.set_aim(SUN_SET_POS)
	set_color_scheme(NIGHT_COLOR_SCHEME)
	
	await night_start.display_start()
	
	for player in players:
		player.reset_actions()
	
	var actions: Dictionary = {}
	for player in players:
		if player.alive:
			await night_present.present(player)
			var player_action: Callable = await night_traits.choose_action(player)
			if player_action != null:
				var t: Trait = player_action.get_object()
				var key = t.name
				if not key in actions:
					actions[key] = []
				actions[key].append(player_action)
	
	for priority in TRAIT_PRIORITY:
		if priority in actions:
			for action in actions[priority]:
				action.call()
	
	var wolves_kill: Player = WolfVotingSystem.get_most_voted_player()
	if wolves_kill != null:
		wolves_kill.receive_attack()
		
	announcements_control.set_text(TranslationManager.get_translation("day_announcements_tonight"))
	await announcements()


func announcements():
	screens.set_phase("ANNOUNCEMENTS")
	sun.set_aim(SUN_MIDDAY_POS)
	set_color_scheme(DAY_COLOR_SCHEME)
	
	if len(public_log) == 0:
		var new_log = LOG_SCENE.instantiate()
		new_log.add_text(TranslationManager.get_translation("announcements_nothing"))
		public_log.append(new_log)
	
	announcements_control.reset()
	
	await announcements_next.pressed
	for one_log in public_log:
		announcements_control.add_log(one_log)
		await announcements_next.pressed
	public_log = []
	
	for player: Player in players:
		for t: Trait in player.traits:
			t.try_win_condition(players)


func discussion():
	screens.set_phase("DISCUSSION")
	await discussion_control.create_discussion()
	await voting()


func voting():
	# TODO: Treat when there is no one to vote
	screens.set_phase("VOTING")
	await voting_start.display_start()
	
	var votable_players: Array[Player] = get_votable_players()
	var votes: Dictionary = {}
	for player in players:
		if player.alive:
			await voting_present.present(player)
			var vote: Player = await voting_vote.vote(player, votable_players)
			if vote != null:
				if not vote in votes:
					votes[vote] = 0
				votes[vote] += 1
	
	var max_votes = 0
	var elected: Array[Player] = []
	for player in votes:
		if votes[player] > max_votes:
			max_votes = votes[player]
			elected = [player]
		elif votes[player] == max_votes:
			elected.append(player)
	
	if len(elected) != 1:
		var draw_log: Log = LOG_SCENE.instantiate()
		draw_log.add_text(TranslationManager.get_translation("voting_tie"))
		create_public_log(draw_log)
	else: 
		var result_log: Log = LOG_SCENE.instantiate()
		result_log.add_image(elected[0].icon)
		result_log.add_text(TranslationManager.get_translation("voting_result") + elected[0].name)
		create_public_log(result_log)
		elected[0].win_election()
	
	announcements_control.set_text(TranslationManager.get_translation("voting_announcements_start"))
	await announcements()


func show_winners():
	screens.set_phase("VICTORY")
	
	victory.display_victory(winners)


# ------------------------------------------------------------------------------
# PUBLIC METHODS
# ------------------------------------------------------------------------------
func create_public_log(new_log):
	public_log.append(new_log)


func create_private_log(new_log):
	private_log.append(new_log)


func add_winner(winner: Winner):
	winners.append(winner)
	pass


func set_color_scheme(new_color_scheme: ColorScheme):
	new_color_scheme.initialize_colors(self.color_scheme.curr_bottom_color, self.color_scheme.curr_top_color, self.color_scheme.curr_sun_color, self.color_scheme.curr_mountains_color, self.color_scheme.curr_base_color, self.color_scheme.curr_font_color)
	self.color_scheme = new_color_scheme


func get_conditioned_players(condition_name: String, value) -> Array[Player]:
	var conditioned_players: Array[Player] = []
	for player in players:
		if player.get(condition_name) == value:
			conditioned_players.append(player)
	return conditioned_players


func get_votable_players() -> Array[Player]:
	var votable = get_conditioned_players("votable", true)
	return get_alive_players().filter(func(p): return p in votable)


func get_alive_players() -> Array[Player]:
	return get_conditioned_players("alive", true)


func get_dead_players() -> Array[Player]:
	return get_conditioned_players("alive", false)
