extends SinglePlayerSelectionTrait


class_name ExampleTrait


## Must set name and icon for this specific trait
func _init():
	name = "Example"
	icon = preload("res://resources/sprites/high_res_emojis/moon.png")


## Returns action description to be used in private logs. Will be created in the
## form A [description] B
func _get_action_description() -> String:
	return "deu exemplo em"


## Performs action
func _perform_action():
	var public_log = LOG_SCENE.instantiate()
	public_log.add_player_received_action_log(player_selected, "recebeu exemplo")
	game.create_public_log(public_log)
