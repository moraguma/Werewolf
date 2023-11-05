extends Control


@onready var components = $Scroll/Components
@onready var opening = $Opening


func set_text(text):
	opening.text = text


func reset():
	for component in components.get_children():
		component.queue_free()


func add_log(log: Log):
	components.add_child(log)
