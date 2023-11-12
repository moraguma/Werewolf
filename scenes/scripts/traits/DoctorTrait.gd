extends SinglePlayerSelectionTrait


class_name DoctorTrait


func _init():
	name = "Doctor"
	icon = preload("res://resources/sprites/high_res_emojis/Doctor.png")


func action_description():
	return "cured/protected"


## Add public and private log. Perform action on target player.
func perform_specific_action():
	player_selected.set("protected", true)
