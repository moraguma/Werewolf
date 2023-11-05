extends Resource


class_name Player


const LOG_SCENE = preload("res://scenes/Log.tscn")


var icon: Texture
var name: String
var game: Game
var color_scheme: ColorScheme

var traits: Array[Trait] = []

var alive = true
var votable = true


func _init(icon: Texture, name: String, color_scheme: ColorScheme):
	self.icon = icon
	self.name = name
	self.color_scheme = color_scheme


func give_trait(t: Trait):
	t.owner = self
	t.game = game
	
	traits.append(t)


func set_game(game: Game):
	self.game = game
	
	for t in traits:
		t.game = game


func win_election():
	var new_log: Log = LOG_SCENE.instantiate()
	new_log.add_image(icon)
	new_log.add_text(name + TranslationManager.get_translation("died_at_gallows"))
	game.create_public_log(new_log)
	
	alive = false
	votable = false
