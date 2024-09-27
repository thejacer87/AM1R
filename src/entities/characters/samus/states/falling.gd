extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var animation := "fall_"
	if samus.is_aiming and Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
			animation += "aim_diag_" + ("down_" if samus.aiming_down else "up_")
	samus.animation_player.play(animation + samus.look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	var input_direction_y := Input.get_axis("up_" + str(samus.player_index), "down_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * signf(input_direction_x) * 0.6667
	
	if Input.is_action_just_pressed("left_" + str(samus.player_index)):
		samus.animation_player.play("fall_" + samus.look_direction)
	if Input.is_action_just_pressed("right_" + str(samus.player_index)):
		samus.animation_player.play("fall_" + samus.look_direction)
	samus.move_and_slide()

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif (not input_direction_y == 0 and not input_direction_x == 0) or Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		handle_diagonal_aiming("fall")
	elif Input.is_action_just_released("diagonal_aim_" + str(samus.player_index)):
		samus.aiming_down = false
		samus.animation_player.play("fall_" + samus.look_direction)
	elif Input.is_action_pressed("up_" + str(samus.player_index)):
		samus.animation_player.play("fall_aim_up_" + samus.look_direction)
	elif Input.is_action_pressed("down_" + str(samus.player_index)):
		print("aim straight down")
		samus.animation_player.play("fall_aim_down_" + samus.look_direction)

	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		samus.velocity.x = 100 * samus.looking
		samus.velocity.y = 66.667
		finished.emit(SPIN_FALLING)

	if samus.is_on_floor():
		if is_equal_approx(samus.velocity.x, 0.0):
			finished.emit(IDLE, {"look_direction": samus.look_direction})
		else:
			finished.emit(RUNNING)
