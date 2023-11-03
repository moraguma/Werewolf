extends Resource


class_name ColorScheme


const STYLE_BOX_NAMES = ["normal", "disabled", "grabber", "grabber_highlight", "grabber_pressed"]
const STYLE_BOX_TYPES = ["Button", "Button", "VScrollBar", "VScrollBar", "VScrollBar"]

const FONT_NAMES = ["font_color", "default_color"]
const FONT_TYPES = ["Button", "RichTextLabel"]

const CHANGE_WEIGHT = 0.01


var bottom_color: Color
var top_color: Color
var sun_color: Color
var mountains_color: Color
var base_color: Color
var font_color: Color

var initialized = false
var curr_bottom_color: Color
var curr_top_color: Color
var curr_sun_color: Color
var curr_mountains_color: Color
var curr_base_color: Color
var curr_font_color: Color


func _init(bottom_color: Color, top_color: Color, sun_color: Color, mountains_color: Color, base_color: Color, font_color: Color):
	self.bottom_color = bottom_color
	self.top_color = top_color
	self.sun_color = sun_color
	self.mountains_color = mountains_color
	self.base_color = base_color
	self.font_color = font_color


func initialize_colors(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	if not initialized:
		initialized = true
		
		curr_bottom_color = sky.material.get_shader_parameter("bottom_color")
		curr_top_color = sky.material.get_shader_parameter("top_color")
		curr_sun_color = sun.material.get_shader_parameter("color")
		curr_mountains_color = mountains.color
		curr_base_color = theme.get_stylebox(STYLE_BOX_NAMES[0], STYLE_BOX_TYPES[0]).bg_color
		curr_font_color = theme.get_color(FONT_NAMES[0], FONT_TYPES[0])


func update_targets(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	sky.material.set_shader_parameter("bottom_color", curr_bottom_color)
	sky.material.set_shader_parameter("top_color", curr_top_color)
	sun.material.set_shader_parameter("color", curr_sun_color)
	mountains.color = curr_mountains_color
	
	for i in range(len(STYLE_BOX_NAMES)):
		var style_box: StyleBoxFlat = theme.get_stylebox(STYLE_BOX_NAMES[i], STYLE_BOX_TYPES[i])
		style_box.bg_color = curr_base_color
		theme.set_stylebox(STYLE_BOX_NAMES[i], STYLE_BOX_TYPES[i], style_box)
	
	for i in range(len(FONT_NAMES)):
		theme.set_color(FONT_NAMES[i], FONT_TYPES[i], curr_font_color)


func update_colors(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	initialize_colors(sky, sun, mountains, theme)
	
	curr_bottom_color = lerp(curr_bottom_color, bottom_color, CHANGE_WEIGHT)
	curr_top_color = lerp(curr_top_color, top_color, CHANGE_WEIGHT)
	curr_sun_color = lerp(curr_sun_color, sun_color, CHANGE_WEIGHT)
	curr_mountains_color = lerp(curr_mountains_color, mountains_color, CHANGE_WEIGHT)
	curr_base_color = lerp(curr_base_color, base_color, CHANGE_WEIGHT)
	curr_font_color = lerp(curr_font_color, font_color, CHANGE_WEIGHT)
	
	update_targets(sky, sun, mountains, theme)


func set_colors(sky: Sprite2D, sun: Sprite2D, mountains: Polygon2D, theme: Theme):
	initialize_colors(sky, sun, mountains, theme)
	
	curr_bottom_color = bottom_color
	curr_top_color = top_color
	curr_sun_color = sun_color
	curr_mountains_color = mountains_color
	curr_base_color = base_color
	curr_font_color = font_color
	
	update_targets(sky, sun, mountains, theme)
