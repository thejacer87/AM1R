extends State

class_name BeamState


func enter() -> void:
	print('beam attached')

	
func handle_input(event: InputEvent):
	if event.is_action_pressed("arm"):
		emit_signal("finished", "missile")
	return .handle_input(event)

func update(delta: float) -> void:
	pass

