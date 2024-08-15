extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var animation := "run_"
	if samus.is_aiming:
		animation += "aim_"
		if Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
			animation += "diag_" + ("down_" if samus.aiming_down else "up_")
	samus.animation_player.play(animation + samus.look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	var input_direction_y := Input.get_axis("up_" + str(samus.player_index), "down_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()
	
	if samus.velocity.x == 0 and samus.is_on_floor():
		print("velocity? " + "")
		var animation := "stand_" + samus.look_direction
		samus.animation_player.play(animation)
		finished.emit(IDLE, {"look_direction": samus.look_direction})


	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(SPIN_JUMPING)
	elif Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE, {"look_direction": samus.look_direction})
	elif not input_direction_y == 0 or Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		handle_diagonal_aiming("run")
	elif samus.is_aiming:
		samus.animation_player.play("run_aim_" + samus.look_direction)
	else:
		samus.animation_player.play("run_" + samus.look_direction)

	if not samus.is_on_floor():
		finished.emit(FALLING)
	
