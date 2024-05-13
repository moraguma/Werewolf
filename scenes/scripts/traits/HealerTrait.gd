extends SinglePlayerSelectionTrait


class_name HealerTrait

func _ready():
	set("name", "healer")
	name = "healer"

## Performs action
func _perform_action():
	player_selected.protected = true


func _get_available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players_except_owner(owner)
