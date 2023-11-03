extends Node2D

class_name Game

# ------------------------------------------------------------------------------
# CONSTANTS
# ------------------------------------------------------------------------------
const TRAIT_PRIORITY: Array[String] = [
	"Trait"
]

const BASE_C1 = Color("#0d4599")
const BASE_C2 = Color("#085298")
const COLOR_CHANGE_WEIGHT = 0.001

# ------------------------------------------------------------------------------
# VARIABLES
# ------------------------------------------------------------------------------
var aim_c1: Color
var aim_c2: Color

var public_log: Array[Log] = []
var private_log: Array[Log] = []

var players: Array[Player] = [Player.new(preload("res://resources/sprites/high_res_emojis/moon.png"), "André", BASE_C1, BASE_C2)]
var winners: Array[Player] = []

# ------------------------------------------------------------------------------
# NODES
# ------------------------------------------------------------------------------
@onready var sky = $BG/Sky
@onready var screens = $Screens

# Night
@onready var night_start = $Screens/Night/Start
@onready var night_present = $Screens/Night/Present
@onready var night_traits = $Screens/Night/Traits


func _ready():
	
	players[0].traits = [Trait.new(), Trait.new(), Trait.new()]
	
	game_loop()


func _process(delta):
	if aim_c1 != null and aim_c2 != null:
		sky.material.set_shader_parameter("c1", lerp(sky.material.get_shader_parameter("c1"), aim_c1, COLOR_CHANGE_WEIGHT))
		sky.material.set_shader_parameter("c2", lerp(sky.material.get_shader_parameter("c2"), aim_c2, COLOR_CHANGE_WEIGHT))


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
	
	await night_start.display_start()
	
	var actions: Array[Array] = []
	for player in players:
		await night_present.present(player)
		actions.append(await night_traits.choose_action(player))
	
	# TODO: Sort by priority
	
	for action in actions:
		action[0].callv(action[1])


func day_announcements():
	for log in public_log:
		# TODO - Create show logic
		log.show() # Should add log info to a control node in Game
	public_log = []
	
	# Await player confirmation before ending


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
func create_public_log():
	pass


func set_bg_color(c1: Color, c2: Color):
	aim_c1 = c1
	aim_c2 = c2
