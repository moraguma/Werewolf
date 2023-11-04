extends Resource


class_name Trait


signal finish_action(result: Array)


const LOG_SCENE = preload("res://scenes/Log.tscn")


var game: Game
var owner: Player
var name = "Trait"
var icon: Texture


## Displays possible trait actions. Should emit the signal finish_action with
## the selected action once the action has been selected
func display_actions(action_display: ActionDisplay):
	action_display.connect("interrupt", handle_interrupt)


func handle_interrupt(interrupt: Interrupt):
	if interrupt.type == Interrupt.Type.EXIT:
		finish_action.emit(null)
