extends ScrollContainer


class_name Log


const COLOR_SCHEME_MATERIAL = preload("res://resources/shaders/materials/ColorSchemer.tres")
const CIRCLE_CUT_MATERIAL = preload("res://resources/shaders/materials/CircleCut.tres")

var EMPTY_STYLE: StyleBox = StyleBoxEmpty.new()
const LABEL_FONT_SIZE = 40


var prepared_components = []
@onready var components = $Components


func _ready():
	for component in prepared_components:
		components.add_child(component)


func add_action_given_log(sender: Player, receiver: Player, action: String):
	add_image(sender.icon)
	add_text(sender.name + " " + action + " " + receiver.name)	# TODO: add translation json to action
	add_image(receiver.icon)


func add_text(text: String):
	var new_text: Label = Label.new()
	new_text.material = COLOR_SCHEME_MATERIAL
	new_text.add_theme_font_size_override("font_size", LABEL_FONT_SIZE)
	new_text.add_theme_stylebox_override("normal", EMPTY_STYLE)
	new_text.text = text
	
	prepared_components.append(new_text)


func add_image(tex: Texture):
	var new_texture_rect: TextureRect = TextureRect.new()
	new_texture_rect.material = CIRCLE_CUT_MATERIAL
	new_texture_rect.texture = tex
	
	prepared_components.append(new_texture_rect)
