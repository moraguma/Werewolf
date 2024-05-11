extends Control


const RELEASE_TIME = 1.0


@onready var base: Game = $"../../../"
@onready var player_icon = $PlayerIcon
@onready var player_name = $PlayerName
@onready var timer = $Timer
@onready var next_button = $Next


## Starts the current turn. Displays player without traits
func present(player: Player):
	show()
	
	player_icon.texture = player.icon
	player_name.text = "[center]" + player.name
	base.set_color_scheme(player.color_scheme)
	
	next_button.hide()
	
	timer.start(RELEASE_TIME)
	await timer.timeout
	
	next_button.show()
	await next_button.pressed
	
	hide()
