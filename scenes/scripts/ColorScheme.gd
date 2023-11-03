extends Resource


class_name ColorScheme


const CHANGE_WEIGHT = 0.01


var bottom_color: Color
var top_color: Color
var sun_color: Color
var mountains_color: Color
var button_base_color: Color
var font_color: Color


func _init(bottom_color: Color, top_color: Color, sun_color: Color, mountains_color: Color, button_base_color: Color, font_color: Color):
	self.bottom_color = bottom_color
	self.top_color = top_color
	self.sun_color = sun_color
	self.mountains_color = mountains_color
	self.button_base_color = button_base_color
	self.font_color = font_color


func update_colors(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	sky.material.set_shader_parameter("bottom_color", lerp(sky.material.get_shader_parameter("bottom_color"), bottom_color, CHANGE_WEIGHT))
	sky.material.set_shader_parameter("top_color", lerp(sky.material.get_shader_parameter("top_color"), top_color, CHANGE_WEIGHT))
	
	sun.material.set_shader_parameter("color", lerp(sun.material.get_shader_parameter("color"), sun_color, CHANGE_WEIGHT))
	
	mountains.color = lerp(mountains.color, mountains_color, CHANGE_WEIGHT)
	
	var button_style_box: StyleBoxFlat = theme.get_stylebox("normal", "Button")
	button_style_box.bg_color = lerp(button_style_box.bg_color, button_base_color, CHANGE_WEIGHT)
	theme.set_stylebox("normal", "Button", button_style_box)
	
	theme.set_color("font_color", "Button", lerp(theme.get_color("font_color", "Button"), font_color, CHANGE_WEIGHT))
	theme.set_color("default_color", "RichTextLabel", lerp(theme.get_color("default_color", "RichTextLabel"), font_color, CHANGE_WEIGHT))


func set_colors(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	sky.material.set_shader_parameter("bottom_color", bottom_color)
	sky.material.set_shader_parameter("top_color", top_color)
	
	sun.material.set_shader_parameter("color", sun_color)
	
	mountains.color = mountains_color
	
	var button_style_box: StyleBoxFlat = theme.get_stylebox("normal", "Button")
	button_style_box.bg_color = button_base_color
	theme.set_stylebox("normal", "Button", button_style_box)
	
	theme.set_color("font_color", "Button", font_color)
	theme.set_color("default_color", "RichTextLabel", font_color)
