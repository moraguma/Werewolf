extends ScrollContainer


class_name Log


const COLOR_SCHEME_MATERIAL = preload("res://resources/shaders/materials/ColorSchemer.tres")
const CIRCLE_CUT_MATERIAL = preload("res://resources/shaders/materials/CircleCut.tres")
const LOG_SCENE = preload("res://scenes/Log.tscn")

const IMAGE_SIZE = Vector2(150.0, 150.0)

var EMPTY_STYLE: StyleBox = StyleBoxEmpty.new()
const LABEL_FONT_SIZE = 40


var prepared_components = []
@onready var components = $Components


func _ready():
	for component in prepared_components:
		components.add_child(component)


func add_full_action_given_log(sender: Player, receiver: Player, action: String):
	add_image(sender.icon)
	var text = "%s (%s) %s %s (%s)"
	add_text(text % [sender.name, sender.traits, action, receiver.name, receiver.traits])	# TODO: add translation json to action
	add_image(receiver.icon)


func add_player_received_action_log(target: Player, action: String):
	add_image(target.icon)
	add_text(target.name + " " + action) # TODO: add translation json to action


func add_text(text: String):
	var new_text: Label = Label.new()
	new_text.material = COLOR_SCHEME_MATERIAL
	new_text.add_theme_font_size_override("font_size", LABEL_FONT_SIZE)
	new_text.add_theme_stylebox_override("normal", EMPTY_STYLE)
	new_text.text = text
	
	prepared_components.append(new_text)


func add_image(tex: Texture2D, circle_cut=true):
	var new_texture_rect: TextureRect = TextureRect.new()
	new_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	new_texture_rect.custom_minimum_size = IMAGE_SIZE
	if circle_cut:
		new_texture_rect.material = CIRCLE_CUT_MATERIAL
	new_texture_rect.texture = tex
	
	prepared_components.append(new_texture_rect)


# --------------------------------------------------------------------------------------------------
# TEMPLATES
# --------------------------------------------------------------------------------------------------
## Returns log that starts with player and trait icon
static func win_template(t: Trait, translation_code: String):
	var log: Log = LOG_SCENE.instantiate()
	log.add_image(t.owner.icon)
	log.add_image(t.icon, false)
	log.add_text(TranslationManager.get_translation(translation_code))
	return log
