extends Node2D


const PHASE_POSITIONS = {
	"NIGHT": Vector2(1080, 0),
	"ANNOUNCEMENTS": Vector2(-1080, 0),
	"DISCUSSION": Vector2(0, -1920),
	"VOTING": Vector2(0, 1920),
	"VICTORY": Vector2(0, 0)
}


func set_phase(phase_name: String):
	position = PHASE_POSITIONS[phase_name]
