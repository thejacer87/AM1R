extends OnGroundState

class_name IdleState


func enter() -> void:
	if is_crouched():
		animation_state.travel("Crouch")
	elif in_morph_ball():
		animation_state.travel("MorphBall")
	else:
		animation_state.travel("Idle")


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if is_crouched():
		if input_direction.x:
			update_blend_positions(["Crouch"])
	elif not is_crouched() or in_morph_ball():
		if input_direction.x:
			update_blend_positions(["Idle", "Move"])
			velocity.x = 0.0
			emit_signal("finished", "move")
		else:
			emit_signal("finished", "idle")

	.update(delta)


func exit() -> void:
	var input_direction = get_input_direction()
	animation_tree.set("parameters/Move/1/TurnRightGate/turn_right/blend_position", -sign(input_direction.x))
	animation_tree.set("parameters/Move/0/TurnLeftGate/turn_left/blend_position", -sign(input_direction.x))
