extends State

class_name CannonState

const BEAM := preload("res://Scenes/Beam.tscn")
const MISSILE := preload("res://Scenes/Missile.tscn")


func handle_input(event: InputEvent):
	if Globals.STATES["Morph"].current_state == Globals.STATES["Morph"].states_map["morph_ball"]:
		emit_signal("finished", "bomb")
	return .handle_input(event)

