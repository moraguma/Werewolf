extends Trait


class_name SinglePlayerSelectionTrait


var selection_button: PlayerSelectionButton
var player_selected: Player

# --------------------------------------------------------------------------------------------------
# INHERIT FUNCTIONS (SUPPOSED TO BE ABSTRACT)
# --------------------------------------------------------------------------------------------------
func _init():
	name = "SinglePlayerSelection"
	icon = preload("res://resources/sprites/high_res_emojis/moon.png")


func action_description():
	return "selected"


func available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players()


## Subclasses must implement their own public log if needed
func write_public_log():
	return null


## Add public and private log. Perform action on target player.
func perform_specific_action():
	pass

# --------------------------------------------------------------------------------------------------

## Displays possible trait actions. Should emit the signal finish_action with
## the selected action once the action has been selected
func display_actions(action_display: ActionDisplay):
	super.display_actions(action_display)
	
	for player_button in available_player_buttons(action_display):
		player_button.connect("selected_player", select_player.bind(player_button))
	
	var confirm_button: Button = action_display.add_button("Confirm")
	confirm_button.connect("pressed", handle_interrupt.bind(Interrupt.new(Interrupt.Type.CONFIRM, null)))


func select_player(player: Player, player_button: PlayerSelectionButton):
	if selection_button != null:
		selection_button.enable()
	player_button.disable()
	
	player_selected = player
	selection_button = player_button


func handle_interrupt(interrupt: Interrupt):
	super.handle_interrupt(interrupt)
	
	if interrupt.type == Interrupt.Type.CONFIRM and player_selected != null:
		finish_action.emit(action.bind(player_selected))


## Default implementation of private log. Shows player sender and receiver.
func write_private_log():
	var private_log: Log = LOG_SCENE.instantiate()
	private_log.add_full_action_given_log(owner, player_selected, action_description())
	return private_log


func action(player: Player):
	game.create_private_log(write_private_log())
	
	var public_log = write_public_log()
	if public_log != null:
		game.create_public_log(public_log)
		
	perform_specific_action()
	print("Test selected - " + player.name)
