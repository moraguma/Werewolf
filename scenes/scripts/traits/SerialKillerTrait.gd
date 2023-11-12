extends SinglePlayerSelectionTrait


class_name SerialKillerTrait


func _init():
	name = TranslationManager.get_translation("serial_killer_name")
	icon = preload("res://resources/sprites/high_res_emojis/knife.png")


## Performs action
func _perform_action():
	if player_selected.receive_attack():
		var public_log: Log = LOG_SCENE.instantiate()
		public_log.add_player_received_action_log(player_selected, TranslationManager.get_translation("serial_killer_public_action"))
		game.create_public_log(public_log)


func _get_action_description() -> String:
	return TranslationManager.get_translation("serial_killer_action_description")


func _get_available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players_except_owner(owner)
