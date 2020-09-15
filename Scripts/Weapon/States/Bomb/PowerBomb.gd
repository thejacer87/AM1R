extends State

class_name PowerBombState

const POWER_BOMB := preload("res://Scenes/Beam.tscn")


func enter() -> void:
	pass


func handle_input(event: InputEvent):
	if Globals.STATES["Morph"].current_state != Globals.STATES["Morph"].states_map["morph_ball"]:
		emit_signal("finished", "beam")
	if event.is_action_released("arm"):
		emit_signal("finished", "bomb")
	if event.is_action_released("shoot"):
		owner.bomb(POWER_BOMB.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
