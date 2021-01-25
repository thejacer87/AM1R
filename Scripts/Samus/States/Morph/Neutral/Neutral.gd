class_name NeutralState
extends MorphState

func enter() -> void:
	._set_collision_state("Neutral")


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("morph_ball") and (owner as Samus).can_morph():
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("down"):
		if motion_state_machine.current_state == Globals.STATES["Motion"].states_map["idle"]:
			emit_signal("finished", "crouch")
