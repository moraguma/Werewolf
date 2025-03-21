extends Resource


class_name Trait


signal finish_action(result: Array)


const LOG_SCENE = preload("res://scenes/Log.tscn")


var game: Game
var owner: Player
var display_name = "Trait"
var icon: Texture
var name = "Trait"

## Must set name and icon for this specific trait
func _init():
	display_name = TranslationManager.get_translation("%s_name" % name)
	icon = load("res://resources/sprites/high_res_emojis/%s.svg" % name)

## Displays possible trait actions. Should emit the signal finish_action with
## the selected action once the action has been selected
func display_actions(action_display: ActionDisplay):
	# Giving error because every night we try to connect again
	# Must connect one time?
	action_display.connect("interrupt", handle_interrupt)


func handle_interrupt(interrupt: Interrupt):
	if interrupt.type == Interrupt.Type.EXIT:
		finish_action.emit(null)


## If win condition has been met, adds a Winner to game
func try_win_condition(players: Array[Player]):
	pass
