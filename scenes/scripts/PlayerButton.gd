extends Control


class_name PlayerSelectionButton


signal selected_player(p: Player)


var p: Player


@onready var player_icon: TextureRect = $PlayerIcon
@onready var player_name: RichTextLabel = $PlayerName
@onready var button: Button = $PlayerIcon/Button
@onready var count: Label = $Count


func setup(param_p: Player):
	p = param_p
	
	player_icon.texture = p.icon
	
	player_name.text = "[center]" + p.name


func pressed():
	selected_player.emit(p)


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
