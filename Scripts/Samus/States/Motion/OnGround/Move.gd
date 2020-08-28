extends OnGroundState

class_name MoveState

var run_speed : float = 10 * Globals.UNIT_SIZE

func enter():
	animation_state.travel("Run")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	animation_tree.set(blend % "Run", input_direction)
	if not input_direction:
		emit_signal("finished", "idle")
	else:
		animation_tree.set(blend % "Idle", input_direction)

	velocity.x = input_direction.x * run_speed
	apply_gravity(delta)
	apply_movement()


func apply_movement() -> void:
	velocity = owner.move_and_slide(velocity, FLOOR)
