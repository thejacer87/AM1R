extends MotionState

class_name OnGroundState

var speed := 0.0

func handle_input(event: InputEvent):
	if morph_state_machine.current_state != Globals.STATES["Morph"].states_map["morph_ball"] and event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	return .handle_input(event)
