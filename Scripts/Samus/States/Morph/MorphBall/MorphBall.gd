extends MorphState

class_name MorphBallState


func enter() -> void:
	animation_state.travel("MorphBall")
	._set_collision_state("MorphBall")


func handle_input(event: InputEvent) -> void:
	if (owner as Samus).has_powerup("morph_ball") and (owner as Samus).can_morph() and (event.is_action_pressed("morph_ball") or event.is_action_pressed("up")):
		if motion_state_machine.current_state == Globals.STATES["Motion"].states_map["jump"] or motion_state_machine.current_state == Globals.STATES["Motion"].states_map["fall"]:
			emit_signal("finished", "neutral")
		else:
			emit_signal("finished", "crouch")
