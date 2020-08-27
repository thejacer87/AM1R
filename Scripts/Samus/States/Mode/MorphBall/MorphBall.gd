extends ModeState

class_name MorphBallState

func handle_input(event):
	if event.is_action_pressed("morph_ball"):
		emit_signal("finished", "crouch")

func enter():
	owner.get_node("AnimationTree").get("parameters/playback").travel("MorphBall")
	owner.get_node("NeutralCollision").set_deferred("disabled", true)
	owner.get_node("CrouchCollision").set_deferred("disabled", true)
	owner.get_node("MorphBallCollision").set_deferred("disabled", false)
