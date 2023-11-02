extends Node


const TRANSLATIONS = {
	"pt": "res://resources/translations/pt.json"
}


var translation_dict: Dictionary


func _ready():
	load_dict("pt")


func load_dict(translation: String):
	var json = JSON.new()
	json.parse(FileAccess.get_file_as_string(TRANSLATIONS[translation]))
	translation_dict = json.data


func get_translation(code: String):
	if code in translation_dict:
		return translation_dict[code]
	push_error("Translation %s not found" % [code])
