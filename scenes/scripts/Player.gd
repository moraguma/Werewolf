extends Resource


class_name Player


var icon: Texture
var name: String
var c1: Color
var c2: Color

var traits: Array[Trait] = []


func _init(icon: Texture, name: String, c1: Color, c2: Color):
	self.icon = icon
	self.name = name
	self.c1 = c1
	self.c2 = c2


