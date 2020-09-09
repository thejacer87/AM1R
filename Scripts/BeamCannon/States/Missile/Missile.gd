extends State

class_name MissileState


func enter() -> void:
	print('missile attached')


func handle_input(event: InputEvent):
	if event.is_action_pressed("arm"):
		emit_signal("finished", "beam")
	return .handle_input(event)


func update(delta: float) -> void:
	pass

