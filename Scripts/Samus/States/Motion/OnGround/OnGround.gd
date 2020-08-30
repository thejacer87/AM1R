extends MotionState

class_name OnGroundState

var speed := 0.0

func handle_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	return .handle_input(event)


func update(delta: float) -> void:
	.apply_gravity(delta)
	.apply_movement()
