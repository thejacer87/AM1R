extends OnGroundState

class_name MoveState

var run_speed : float = 10 * Globals.UNIT_SIZE


func enter():
	if mode_state_machine.current_state:
		if mode_state_machine.current_state == mode_state_machine.states_map["crouch"]:
			animation_state.travel("Crouch")
			emit_signal("finished", "crouch")
		elif mode_state_machine.current_state == mode_state_machine.states_map["morph_ball"]:
			animation_state.travel("MorphBall")
		else:
			animation_state.travel("Move")
	else:
		animation_state.travel("Move")


func handle_input(event):
	return .handle_input(event)


func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		animation_tree.set(blend % "Idle", input_direction)
		animation_tree.set(blend % "Move", input_direction)
		animation_tree.set(blend % "MorphBall", input_direction)
	else:
		emit_signal("finished", "idle")

	velocity.x = input_direction.x * run_speed
	.apply_gravity(delta)
	.apply_movement()
