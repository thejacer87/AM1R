extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("morph")
	samus.animation_player.play("morph_ball")


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)) or Input.is_action_just_pressed("up_" + str(samus.player_index)):
		if not samus.is_on_floor():
			finished.emit(FALLING)
		else:
			finished.emit(CROUCHING)


func exit() -> void:
	super.exit()
	super.update_collisions("")
