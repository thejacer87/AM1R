extends AirborneState

class_name JumpState


func enter() -> void:
	Globals.GameSFX.play(Globals.sfx['jump'])
	var input_direction = get_input_direction()

	if in_morph_ball():
		animation_state.travel("MorphBall")
	else:
# warning-ignore:standalone_ternary
		animation_state.travel("SpinJump") if input_direction.x else animation_state.travel("Jump")
		is_spinning = bool(input_direction.x)

	velocity = enter_velocity if input_direction else Vector2.ZERO
	velocity.y = max_jump_velocity


func handle_input(event: InputEvent):
	if event.is_action_released("jump") && velocity.y < min_jump_velocity:
		velocity.y = min_jump_velocity
	return .handle_input(event)


func update(delta: float) -> void:
	if owner.is_on_ceiling():
		velocity.y = 0

	if velocity.y >= 0:
		emit_signal("finished", "fall")

	.update(delta)


func exit() -> void:
	velocity = Vector2.ZERO
	enter_velocity = Vector2.ZERO
