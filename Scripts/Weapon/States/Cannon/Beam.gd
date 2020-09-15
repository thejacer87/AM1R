extends CannonState

class_name BeamState


func enter() -> void:
	pass


func handle_input(event: InputEvent):
	if event.is_action_pressed("arm"):
		emit_signal("finished", "missile")
	if event.is_action_pressed("shoot"):
		owner.fire(BEAM.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
