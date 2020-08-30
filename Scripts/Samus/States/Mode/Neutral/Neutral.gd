extends MorphState

class_name NeutralState

func handle_input(event):
	if event.is_action_pressed("morph_ball"):
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("down"):
		emit_signal("finished", "crouch")


func enter() -> void:
	animation_state.travel("Idle")
	._set_collision_state("Neutral")

