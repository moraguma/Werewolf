extends Node2D


const PHASE_POSITIONS = {
	"NIGHT": Vector2(1080, 0),
	"DAY_ANNOUNCEMENTS": Vector2(-1080, 0)
}


func set_phase(phase_name: String):
	position = PHASE_POSITIONS[phase_name]
