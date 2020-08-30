extends OnGroundState

class_name MoveState

const RUN_SPEED := 17.75 * Globals.UNIT_SIZE
const MORPH_SPEED := 21 * Globals.UNIT_SIZE

func enter():
	speed = RUN_SPEED
	if morph_state_machine.current_state == morph_state_machine.states_map["morph_ball"]:
		speed = MORPH_SPEED
		animation_state.travel("MorphBall")
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

	velocity.x = sign(input_direction.x) * speed
	.apply_gravity(delta)
	if morph_state_machine.current_state == morph_state_machine.states_map["crouch"]:
		emit_signal("finished", "idle")
	else:
		.apply_movement()
		
