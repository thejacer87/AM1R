extends OnGroundState

class_name IdleState

func enter():
	animation_state.travel("Idle")

func handle_input(event: InputEvent):
	return .handle_input(event)

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	animation_tree.set(blend % "Idle", input_direction)
	if input_direction:
		emit_signal("finished", "run")
	.apply_gravity(delta)
	.apply_movement()
