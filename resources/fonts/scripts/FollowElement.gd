extends Sprite2D


const MOVE_WEIGHT = 0.05


var aim: Vector2


func _process(delta):
	if aim != null:
		position = lerp(position, aim, MOVE_WEIGHT)


func set_aim(aim):
	self.aim = aim