extends OnGroundState

class_name IdleState


func enter() -> void:
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		animation_state.travel("Crouch")
	elif morph_state_machine.current_state == morph_state_machine.states_map["morph_ball"]:
		animation_state.travel("MorphBall")
	else:
		animation_state.travel("Idle")


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		if input_direction.x:
			update_blend_position("Crouch")
	elif morph_state_machine.current_state != morph_state_machine.states_map["crouch"] or morph_state_machine.current_state != morph_state_machine.states_map["morph_ball"]:
		if input_direction.x:
			update_blend_position("Idle")
			update_blend_position("Move")
			emit_signal("finished", "move")
			velocity.x = 0.0
		else:
			emit_signal("finished", "idle")

	.update(delta)


func exit() -> void:
	var input_direction = get_input_direction()
	animation_tree.set("parameters/Move/1/TurnRightGate/turn_right/blend_position", -sign(input_direction.x))
	animation_tree.set("parameters/Move/0/TurnLeftGate/turn_left/blend_position", -sign(input_direction.x))
