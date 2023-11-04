extends Game

func _ready():
	for i in range(10):
		var test_player = Player.new(preload("res://resources/sprites/players/andre.png"), "André", ColorScheme.new(Color.AQUA, Color.AZURE, Color.BISQUE, Color.CHOCOLATE, Color.CRIMSON, Color.BLACK))
		var test_traits: Array[Trait] = [ExampleTrait.new(), ExampleTrait.new(), ExampleTrait.new()]
		test_player.traits = test_traits
		players.append(test_player)
	
	for control in [night_control, day_announcements_control, discussion_control, voting_control]:
		control.theme = THEME
	color_scheme = NIGHT_COLOR_SCHEME
	color_scheme.set_colors(sky, sun, mountains, THEME)
	sun.position = SUN_SET_POS
	
	
	pass


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


func set_color_scheme(color_scheme: ColorScheme):
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
