extends Button


@export var text_code: String


func _ready():
	text = TranslationManager.get_translation(text_code)
