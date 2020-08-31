extends AirborneState

class_name FallState

func enter() -> void:
	var input_direction = get_input_direction()

	if morph_state_machine.current_state != morph_state_machine.states_map["morph_ball"]:
		if animation_state.get_current_node() == "SpinJump":
			animation_state.travel("SpinFall")
		else:
			animation_state.travel("Fall")

	velocity = enter_velocity


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		update_blend_position("SpinFall")
		update_blend_position("Fall")
		if sign(velocity.x) != sign(input_direction.x): 
			velocity.x = aerial_speed * sign(input_direction.x)

	if velocity.y >= 0 and owner.is_on_floor():
		animation_state.travel("Idle")
		emit_signal("finished", "idle")

	.update(delta)
