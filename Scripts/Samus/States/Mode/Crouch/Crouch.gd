extends MorphState


onready var timer = $Timer


func handle_input(event: InputEvent):
	if event.is_action_pressed("morph_ball") or event.is_action_pressed("down"):
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("up"):
		emit_signal("finished", "neutral")
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		timer.start()
	if Input.is_action_just_released("right"):
		timer.stop()
	if Input.is_action_just_released("left"):
		timer.stop()
	return .handle_input(event)


func enter() -> void:
	animation_state.travel("Crouch")
	._set_collision_state("Crouch")
	

func _on_Timer_timeout():
	emit_signal("finished", "neutral")
