extends State

class_name BeamState

const BEAM := preload("res://Scenes/Beam.tscn")


func enter() -> void:
	pass


func handle_input(event: InputEvent):
	if event.is_action_pressed("arm"):
		emit_signal("finished", "missile")
	if event.is_action_pressed("morph_ball"):
		emit_signal("finished", "bomb")
	if event.is_action_pressed("shoot"):
		owner.fire(BEAM.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
