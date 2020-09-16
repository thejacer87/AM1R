extends State

class_name BombState

const BOMB := preload("res://Scenes/Bomb.tscn")


func enter() -> void:
	pass

func handle_input(event: InputEvent):
	if Globals.STATES["Morph"].current_state != Globals.STATES["Morph"].states_map["morph_ball"]:
		emit_signal("finished", "beam")
	if event.is_action_pressed("shoot"):
		owner.bomb(BOMB.instance())
	return .handle_input(event)


func update(delta: float) -> void:
	.update(delta)
