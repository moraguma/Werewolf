extends Control


signal end_discussion()


const STARTING_TIME = 90
const MAX_TIME = 300
const ADD_TIME = 30


@onready var timer: Timer = $Timer
@onready var time_text: RichTextLabel = $TimeText


var active = false


func _process(_delta):
	if active:
		var time = ceil(timer.time_left)
		var minutes = floor(time / 60)
		time_text.text = "[center]%02d:%02d" % [minutes, time - minutes * 60]


func create_discussion():
	active = true
	timer.start(STARTING_TIME)
	await end_discussion


func add_time():
	timer.start(clamp(timer.time_left + ADD_TIME, 0, MAX_TIME))


func end():
	active = false
	end_discussion.emit()
