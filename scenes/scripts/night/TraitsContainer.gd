extends VBoxContainer


const TRAIT_SELECTION_BUTTON_SCENE = preload("res://scenes/TraitSelectionButton.tscn")
const THEME = preload("res://resources/themes/game.tres")
const MAX_TRAITS_PER_LINE = 2


func display_traits(traits: Array[Trait]) -> Array:
	for child in get_children():
		child.queue_free()
	var current_hbox = new_hbox()
	var traits_in_line = 0
	
	var trait_buttons = []
	for t in traits:
		if traits_in_line >= MAX_TRAITS_PER_LINE:
			current_hbox = new_hbox()
			traits_in_line = 0
		var new_button = TRAIT_SELECTION_BUTTON_SCENE.instantiate()
		current_hbox.add_child(new_button)
		new_button.setup(t) 
		traits_in_line += 1
		
		trait_buttons.append(new_button)
	return trait_buttons


func new_hbox() -> HBoxContainer:
	var new_hbox = HBoxContainer.new()
	new_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	new_hbox.theme = THEME
	add_child(new_hbox)
	return new_hbox
