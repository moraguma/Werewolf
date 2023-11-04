extends VBoxContainer


class_name ExpandingContainer


func display_elements(elements: Array, element_selection_button_scene, max_elements_per_line: int) -> Array:
	for child in get_children():
		child.queue_free()
	var current_hbox = new_hbox()
	var elements_in_line = 0
	
	var element_buttons = []
	for e in elements:
		if elements_in_line >= max_elements_per_line:
			current_hbox = new_hbox()
			elements_in_line = 0
		var new_button = element_selection_button_scene.instantiate()
		current_hbox.add_child(new_button)
		new_button.setup(e) 
		elements_in_line += 1
		
		element_buttons.append(new_button)
	return element_buttons


func new_hbox() -> HBoxContainer:
	var new_hbox = HBoxContainer.new()
	new_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(new_hbox)
	return new_hbox
