extends State

class_name BombState

const BOMB := preload("res://Scenes/Beam.tscn")


func enter() -> void:
	pass


func handle_input(event: InputEvent):
	if event.is_action_pressed("arm"):
		emit_signal("finished", "power_bomb")
	if event.is_action_pressed("shoot"):
		owner.bomb(BOMB.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
