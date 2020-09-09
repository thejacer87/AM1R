extends AirborneState

class_name JumpState


func enter() -> void:
	var input_direction = get_input_direction()

	if in_morph_ball():
		animation_state.travel("MorphBall")
	else:
		animation_state.travel("SpinJump") if input_direction else animation_state.travel("Jump")

	velocity = enter_velocity if input_direction else Vector2.ZERO
	velocity.y = max_jump_velocity


func handle_input(event: InputEvent):
	if event.is_action_released("jump") && velocity.y < min_jump_velocity:
		velocity.y = min_jump_velocity
	return .handle_input(event)


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		update_blend_position("SpinFall")
		update_blend_position("Fall")
		update_blend_position("SpinJump")
		update_blend_position("Jump")
		update_blend_position("Idle")
		update_blend_position("Move")
		if sign(velocity.x) != sign(input_direction.x):
			velocity.x = aerial_speed * sign(input_direction.x)

	if owner.is_on_ceiling():
		velocity.y = 0

	if velocity.y >= 0:
		emit_signal("finished", "fall")

	.update(delta)
