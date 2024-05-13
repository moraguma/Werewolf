extends SinglePlayerSelectionTrait


class_name WolfTrait


func _init():
	name = TranslationManager.get_translation("wolf_name")
	icon = preload("res://resources/sprites/high_res_emojis/wolf.svg")


## Performs action
func _perform_action():
	player_selected = true


func _get_action_description() -> String:
	return TranslationManager.get_translation("wolf_action_description")


func _get_available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players_except_owner(owner)
