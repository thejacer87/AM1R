extends MorphState

class_name MorphBallState

func handle_input(event):
	if event.is_action_pressed("morph_ball") or event.is_action_pressed("up"):
		emit_signal("finished", "crouch")


func enter() -> void:
	animation_state.travel("MorphBall")
	._set_collision_state("MorphBall")
