extends OnGroundState

class_name IdleState

func enter():
	if mode_state_machine.current_state:
			if mode_state_machine.current_state == mode_state_machine.states_map["crouch"]:
				animation_state.travel("Crouch")
			elif mode_state_machine.current_state == mode_state_machine.states_map["morph_ball"]:
				animation_state.travel("MorphBall")
			else:
				animation_state.travel("Idle")
	else:
		animation_state.travel("Idle")

func handle_input(event: InputEvent):
	return .handle_input(event)

func update(delta: float) -> void:
	if mode_state_machine.current_state:
		if mode_state_machine.current_state != mode_state_machine.states_map["crouch"] or mode_state_machine.current_state != mode_state_machine.states_map["morph_ball"]:
			var input_direction = get_input_direction()
			if input_direction:
				animation_tree.set(blend % "Idle", input_direction)
				emit_signal("finished", "move")
	.apply_gravity(delta)
	.apply_movement()
