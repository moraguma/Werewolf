extends Control


const RELEASE_TIME = 1.0


@onready var base: Game = $"../../../"
@onready var player_icon = $PlayerIcon
@onready var player_name = $PlayerName
@onready var timer = $Timer
@onready var next_button = $Next


func present(player: Player):
	show()
	
	player_icon.texture = player.icon
	player_name.text = "[center]" + player.name
	base.set_color_scheme(player.color_scheme)
	
	next_button.disabled = true
	
	timer.start(RELEASE_TIME)
	await timer.timeout
	
	next_button.disabled = false
	await next_button.pressed
	
	hide()
