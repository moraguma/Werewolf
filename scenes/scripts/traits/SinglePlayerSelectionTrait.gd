extends Trait


class_name SinglePlayerSelectionTrait


var selection_button: PlayerSelectionButton
var selection: Player

# --------------------------------------------------------------------------------------------------
# INHERIT FUNCTIONS (SUPPOSED TO BE ABSTRACT)
# --------------------------------------------------------------------------------------------------
func _init():
	name = "PlayerSelection"
	icon = preload("res://resources/sprites/high_res_emojis/moon.png")


func action_description():
	return "selected"


func available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players()
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
	
	selection = player
	selection_button = player_button


func handle_interrupt(interrupt: Interrupt):
	super.handle_interrupt(interrupt)
	
	if interrupt.type == Interrupt.Type.CONFIRM and selection != null:
		finish_action.emit(action.bind(selection))


func action(player: Player):
	var new_log: Log = LOG_SCENE.instantiate()
	new_log.add_action_given_log(owner, player, action_description())
	game.create_public_log(new_log)
	
	print("Test selected - " + player.name)
