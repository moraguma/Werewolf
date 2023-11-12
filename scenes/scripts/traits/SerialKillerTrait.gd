extends SinglePlayerSelectionTrait


class_name SerialKillerTrait


func _init():
	name = "Serial Killer"
	icon = preload("res://resources/sprites/high_res_emojis/knife.png")


func action_description():
	return "killed"


func available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players_except_owner(owner)


## Subclasses must implement their own public log if needed
func write_public_log():
	var public_log: Log = LOG_SCENE.instantiate()
	public_log.add_player_received_action_log(player_selected, "was killed by the Serial Killer")
	return public_log


## Add public and private log. Perform action on target player.
func perform_specific_action():
	player_selected.receive_attack()
