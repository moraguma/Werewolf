extends Control


@onready var components = $Scroll/Components


func reset():
	for component in components.get_children():
		component.queue_free()


func add_log(log: Log):
	components.add_child(log)
