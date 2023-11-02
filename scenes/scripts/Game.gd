extends Node2D


const TRAIT_PRIORITY: Array[String] = [
	"TRAIT"
]

var public_log: Array[Log] = []
var private_log: Array[Log] = []

var players: Array[Player] = []
var winners: Array[Player] = []


func _ready():
	game_loop()


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
	var actions: Array[Array] = []
	for player in players:
		await player.present()
		actions.append(await player.choose_action())
	
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
