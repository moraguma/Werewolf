extends Resource


class_name Player


var icon: Texture
var name: String
var game: Game
var color_scheme: ColorScheme

var traits: Array[Trait] = []

var alive = true


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
