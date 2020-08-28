extends ModeState

class_name CrouchState

func handle_input(event):
	if event.is_action_pressed("morph_ball") or event.is_action_pressed("down"):
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("up"):
		emit_signal("finished", "neutral")


func enter() -> void:
	animation_state.travel("Crouch")
	._set_collision_state("Crouch")
