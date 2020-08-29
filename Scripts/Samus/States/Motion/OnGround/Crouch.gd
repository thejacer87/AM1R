extends OnGroundState

func enter():
	pass

func handle_input(event: InputEvent):
	if event.is_action_pressed("up") or event.is_action_pressed("morph_ball") or event.is_action_pressed("down"):
		emit_signal("finished", "idle")
	return .handle_input(event)

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		animation_tree.set(blend % "Crouch", input_direction)
	.apply_gravity(delta)
