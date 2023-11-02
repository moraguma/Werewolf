extends Resource


class_name Trait


var name = "Trait"
var icon: Texture = preload("res://resources/sprites/high_res_emojis/moon.png")


## Coroutine responsible for displaying possible trait actions. Should return an 
## (Callable, Array) or (null, null), in the case of no action selected
func display_actions(action: ActionDisplay) -> Array:
	return [null, null]
