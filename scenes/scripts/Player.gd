extends Resource


class_name Player


var icon: Texture
var name: String
var color_scheme: ColorScheme

var traits: Array[Trait] = []


func _init(icon: Texture, name: String, color_scheme: ColorScheme):
	self.icon = icon
	self.name = name
	self.color_scheme = color_scheme


