extends MorphState

class_name MorphBallState

func handle_input(event):
	if event.is_action_pressed("morph_ball") or event.is_action_pressed("up"):
		if motion_state_machine.current_state == motion_state_machine.states_map["jump"]:
			emit_signal("finished", "neutral")
		else:
			emit_signal("finished", "crouch")


func enter() -> void:
	animation_state.travel("MorphBall")
	._set_collision_state("MorphBall")
