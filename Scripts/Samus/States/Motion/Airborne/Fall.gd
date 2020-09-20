extends AirborneState

class_name FallState


func enter() -> void:
	if in_morph_ball():
		animation_state.travel("MorphBall")
	else:
		if animation_state.get_current_node() != "SpinJump":
			animation_state.travel("Fall")
		is_spinning = animation_state.get_current_node() == "SpinJump"

	velocity = enter_velocity


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		update_blend_positions(["Fall", "Jump", "Idle", "Move"])
		if sign(velocity.x) != sign(input_direction.x):
			velocity.x = aerial_speed * sign(input_direction.x)

	if velocity.y >= 0 and owner.is_on_floor():
		animation_state.travel("Idle")
		emit_signal("finished", "idle")

	.update(delta)

func exit() -> void:
	velocity = Vector2.ZERO
	
