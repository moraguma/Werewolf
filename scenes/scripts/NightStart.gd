extends Control


const C1 = Color("#1d0445")
const C2 = Color("#1f1a32")


@onready var game: Game = $"../../../"
@onready var next_button: Button = $Next


func display_start():
	show()
	game.set_bg_color(C1, C2)
	await next_button.pressed
	hide()
