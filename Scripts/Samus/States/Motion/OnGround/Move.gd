extends OnGroundState

class_name MoveState

const RUN_SPEED := 7 * Globals.UNIT_SIZE
const MORPH_SPEED := RUN_SPEED * 1.5


func enter() -> void:
	speed = RUN_SPEED
	var travel = "Move"
	if in_morph_ball():
		speed = MORPH_SPEED
		travel = "MorphBall"

	animation_state.travel(travel)


func handle_input(event: InputEvent):
	if in_morph_ball():
		speed = MORPH_SPEED
	return .handle_input(event)


func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction.x:
		update_blend_positions(["Idle", "Move", "Jump", "SpinJump", "Fall", "Neutral", "Crouch", "MorphBall"])
	else:
		emit_signal("finished", "idle")

	# Change to idle if crouching so Samus stops moving
	if is_crouched():
		emit_signal("finished", "idle")

	if not owner.is_on_floor():
		emit_signal("finished", "fall")

	velocity.x = sign(input_direction.x) * speed
	.update(delta)
