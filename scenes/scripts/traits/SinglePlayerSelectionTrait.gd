extends Trait


class_name SinglePlayerSelectionTrait


var selection_button: PlayerSelectionButton
var player_selected: Player

# --------------------------------------------------------------------------------------------------
# VIRTUAL METHODS
# --------------------------------------------------------------------------------------------------
## Returns action description to be used in private logs. Will be created in the
## form A [description] B
func _get_action_description() -> String:
	return TranslationManager.get_translation(name + "_action_description")


## Returns the available player buttons
func _get_available_player_buttons(action_display: ActionDisplay) -> Array:
	return action_display.display_alive_players()


## Performs action
func _perform_action():
	pass
# --------------------------------------------------------------------------------------------------
# METHODS
# --------------------------------------------------------------------------------------------------
## Performs the traits action to the selected player
func action(player: Player):
	var private_log: Log = LOG_SCENE.instantiate()
	private_log.add_full_action_given_log(owner, player_selected, _get_action_description())
	
	game.create_private_log(private_log)
	
	_perform_action()


func display_actions(action_display: ActionDisplay):
	super.display_actions(action_display)
	
	for player_button in _get_available_player_buttons(action_display):
		player_button.connect("selected_player", select_player.bind(player_button))
	
	var confirm_button: Button = action_display.add_button("Confirm")
	confirm_button.connect("pressed", handle_interrupt.bind(Interrupt.new(Interrupt.Type.CONFIRM, null)))


func handle_interrupt(interrupt: Interrupt):
	super.handle_interrupt(interrupt)
	
	if interrupt.type == Interrupt.Type.CONFIRM and player_selected != null:
		finish_action.emit(action.bind(player_selected))


func select_player(player: Player, player_button: PlayerSelectionButton):
	if selection_button != null:
		selection_button.enable()
	player_button.disable()
	
	player_selected = player
	selection_button = player_button
