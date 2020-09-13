extends AirborneState

class_name FallState


func enter() -> void:
	var input_direction = get_input_direction()

	if in_morph_ball():
		animation_state.travel("MorphBall")
	else:
		animation_state.travel("SpinFall") if animation_state.get_current_node() == "SpinJump" else animation_state.travel("Fall")

	velocity = enter_velocity


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		update_blend_position("SpinFall")
		update_blend_position("Fall")
		update_blend_position("Jump")
		update_blend_position("Idle")
		update_blend_position("Move")
		if sign(velocity.x) != sign(input_direction.x):
			velocity.x = aerial_speed * sign(input_direction.x)

	if velocity.y >= 0 and owner.is_on_floor():
		animation_state.travel("Idle")
		emit_signal("finished", "idle")
		
	print(velocity.y)
#	velocity.y = min(velocity.y, MAX_FALL_SPEED)

	.update(delta)
