extends OnGroundState

class_name MoveState

const RUN_SPEED := 7.75 * Globals.UNIT_SIZE
const MORPH_SPEED := 10 * Globals.UNIT_SIZE


func enter() -> void:
	speed = RUN_SPEED
	var travel = "Move"
	if morph_state_machine.current_state == morph_state_machine.states_map["morph_ball"]:
		speed = MORPH_SPEED
		travel = "MorphBall"

	animation_state.travel(travel)
	

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		update_blend_position("Idle")
		update_blend_position("Move")
		update_blend_position("Jump")
		update_blend_position("Fall")
		update_blend_position("Neutral")
		update_blend_position("Crouch")
		update_blend_position("MorphBall")
	else:
		emit_signal("finished", "idle")

	# Change to idle if crouching so Samus stops moving
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		emit_signal("finished", "idle")

	velocity.x = sign(input_direction.x) * speed
	.update(delta)
