extends MotionState

class_name OnGroundState

var speed = 0.0

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	return .handle_input(event)
