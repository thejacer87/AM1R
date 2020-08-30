extends OnGroundState

class_name IdleState

func enter():
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		animation_state.travel("Crouch")
	elif morph_state_machine.current_state == morph_state_machine.states_map["morph_ball"]:
		animation_state.travel("MorphBall")
	else:
		animation_state.travel("Idle")


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		if input_direction:
			update_blend_position("Crouch")
	elif morph_state_machine.current_state != morph_state_machine.states_map["crouch"] or morph_state_machine.current_state != morph_state_machine.states_map["morph_ball"]:
		if input_direction.x:
			update_blend_position("Idle")
			update_blend_position("Move")
			emit_signal("finished", "move")
			velocity.x = 0.0
	.update(delta)
