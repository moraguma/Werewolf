extends TextureButton


class_name TraitSelectionButton


signal selected_trait(t: Trait)


var t: Trait


@onready var trait_name: RichTextLabel = $TraitName


func setup(t: Trait):
	self.t = t
	
	texture_normal = t.icon
	texture_pressed = t.icon
	texture_hover = t.icon
	texture_disabled = t.icon
	texture_focused = t.icon
	
	trait_name.text = "[center]" + t.name


func _pressed():
	selected_trait.emit(t)
