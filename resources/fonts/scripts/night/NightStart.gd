extends Control


@onready var game: Game = $"../../../"
@onready var next_button: Button = $Next


func display_start():
	show()
	await next_button.pressed
	hide()
