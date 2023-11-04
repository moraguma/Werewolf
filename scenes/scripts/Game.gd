extends Node2D

class_name Game

# --------------------------------------------------------------------------------------------------
# CONSTANTS
# --------------------------------------------------------------------------------------------------
const TRAIT_PRIORITY: Array[String] = [
	"Trait"
]

# Visual -----------------------------------------------------------------------
const THEME = preload("res://resources/themes/game.tres")
var NIGHT_COLOR_SCHEME = ColorScheme.new(Color("#8a1471"), Color("#161b57"), Color("#cd3e44"), Color("#140918"), Color("#501c40"), Color("#f4e1fb"))

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
var winners: Array[Player] = []

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
@onready var day_announcements_control = $Screens/DayAnnouncements
@onready var day_announcements_next = $Screens/DayAnnouncements/Next

# Discussion -------------------------------------------------------------------
@onready var discussion_control = $Screens/Discussion

# Voting -----------------------------------------------------------------------
@onready var voting_control = $Screens/Voting



func _ready():
	for i in range(3):
		var test_player = Player.new(preload("res://resources/sprites/players/andre.png"), "André", ColorScheme.new(Color.AQUA, Color.AZURE, Color.BISQUE, Color.CHOCOLATE, Color.CRIMSON, Color.BLACK))
		for j in range(3):
			test_player.give_trait(ExampleTrait.new())
		players.append(test_player)
	
	for player in players:
		player.set_game(self)
	
	for control in [night_control, day_announcements_control, discussion_control, voting_control]:
		control.theme = THEME
	color_scheme = NIGHT_COLOR_SCHEME
	color_scheme.set_colors(sky, sun, mountains, THEME)
	sun.position = SUN_SET_POS
	
	
	game_loop()


func _process(delta):
	color_scheme.update_colors(sky, sun, mountains, THEME)

func game_loop():
	var phases: Array[Callable] = [
		night,
		day_announcements,
		discussion,
		voting
	]
	
	while winners == []:
		for phase in phases:
			await phase.call()
			if winners != []:
				break
	
	show_winners(winners)


func night():
	screens.set_phase("NIGHT")
	sun.set_aim(SUN_SET_POS)
	
	await night_start.display_start()
	
	var actions: Array[Callable] = []
	for player in players:
		await night_present.present(player)
		actions.append(await night_traits.choose_action(player))
	
	# TODO: Sort by priority
	
	for action in actions:
		if action != null:
			action.call()


func day_announcements():
	screens.set_phase("DAY_ANNOUNCEMENTS")
	sun.set_aim(SUN_MIDDAY_POS)
	
	if len(public_log) == 0:
		var new_log = LOG_SCENE.instantiate()
		new_log.add_text(TranslationManager.get_translation("day_announcements_nothing"))
		public_log.append(new_log)
	
	day_announcements_control.reset()
	
	await day_announcements_next.pressed
	for log in public_log:
		day_announcements_control.add_log(log)
		await day_announcements_next.pressed
	public_log = []


func discussion():
	# Open discussion screen
	# Start timer
	# Wait until timer ends
	# Close discussion screen
	
	pass


func voting():
	var votes: Dictionary = {}
	for player in players:
		var vote: Player = await player.ask_for_vote()
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
		# TODO - Show draw screen
		# TODO - Give player election if they should win on draw
		pass
	else: 
		# TODO - Show elected player (elected[0])
		pass


func show_winners(winners: Array[Player]):
	# TODO - Show winners
	# TODO - Show game over screen
	
	pass


# ------------------------------------------------------------------------------
# PUBLIC METHODS
# ------------------------------------------------------------------------------
func create_public_log(log):
	public_log.append(log)


func set_color_scheme(color_scheme: ColorScheme):
	color_scheme.initialize_colors(self.color_scheme.curr_bottom_color, self.color_scheme.curr_top_color, self.color_scheme.curr_sun_color, self.color_scheme.curr_mountains_color, self.color_scheme.curr_base_color, self.color_scheme.curr_font_color)
	self.color_scheme = color_scheme


func get_conditioned_players(players: Array[Player], condition_name: String, value) -> Array[Player]:
	var conditioned_players: Array[Player] = []
	for player in players:
		if player.get(condition_name) == value:
			conditioned_players.append(player)
	return conditioned_players


func get_alive_players() -> Array[Player]:
	return get_conditioned_players(players, "alive", true)


func get_dead_players() -> Array[Player]:
	return get_conditioned_players(players, "alive", false)
