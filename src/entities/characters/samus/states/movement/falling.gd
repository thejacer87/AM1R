extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.animation_player.play("fall_" + look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x * 0.6667
	samus.move_and_slide()

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)

	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		samus.velocity.x = 100 * samus.looking
		samus.velocity.y = 66.667
		finished.emit(SPIN_FALLING)

	if samus.is_on_floor():
		if is_equal_approx(samus.velocity.x, 0.0):
			finished.emit(IDLE, {"look_direction": look_direction})
		else:
			finished.emit(RUNNING)
