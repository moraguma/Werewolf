extends Control


class_name PlayerSelectionButton


signal selected_player(p: Player)


var player: Player


@onready var player_icon: TextureRect = $PlayerIcon
@onready var player_name: RichTextLabel = $PlayerName
@onready var button: Button = $PlayerIcon/Button
@onready var count: Label = $Count


func setup(param_p: Player):
	player = param_p
	
	player_icon.texture = player.icon
	
	player_name.text = "[center]" + player.name


func pressed():
	selected_player.emit(player)


func disable():
	button.disabled = true


func enable():
	button.disabled = false


func display_count(value: int):
	if value > 0:
		count.show()
		count.text = str(value)
	else:
		count.hide()
