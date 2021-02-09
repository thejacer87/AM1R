extends State

class_name BombState


func handle_input(event: InputEvent):
	if Globals.STATES["Morph"].current_state != Globals.STATES["Morph"].states_map["morph_ball"]:
		emit_signal("finished", "beam")
	if event.is_action_pressed("shoot"):
		owner.bomb(Globals.BOMB.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
