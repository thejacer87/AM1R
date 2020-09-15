extends State

class_name MissileState

const MISSILE := preload("res://Scenes/Missile.tscn")


func enter() -> void:
	pass


func handle_input(event: InputEvent):
	if event.is_action_released("arm"):
		emit_signal("finished", "beam")
	if event.is_action_released("shoot"):
		owner.fire(MISSILE.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
