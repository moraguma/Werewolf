extends VBoxContainer


class_name TraitSelectionButton


signal selected_trait(t: Trait)


var t: Trait


@onready var button: TextureButton = $Button
@onready var trait_name: RichTextLabel = $TraitName


func setup(t: Trait):
	self.t = t
	
	button.texture_normal = t.icon
	button.texture_pressed = t.icon
	button.texture_hover = t.icon
	button.texture_disabled = t.icon
	button.texture_focused = t.icon
	
	trait_name.text = "[center]" + t.name


func pressed():
	selected_trait.emit(t)
