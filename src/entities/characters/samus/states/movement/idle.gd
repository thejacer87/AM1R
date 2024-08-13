class_name Idle
extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.x = 0.0
	var animation := "stand_"
	if samus.is_aiming and Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		animation += "aim_diag_" + ("down_" if samus.aiming_down else "up_")
	samus.animation_player.play(animation + samus.look_direction)
	samus.idle_timer.start()


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	#samus.move_and_slide()
	#if samus.idle_timer.time_left == 0:
		#samus.animation_player.play("idle_" + samus.look_direction)
	# Handle aiming first.
	
	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("left_" + str(samus.player_index)):
		# seems to do nothing. i dont want to start the run when turning from idle
		if samus.looking == samus.look_directions.RIGHT:
			pass
		else:
			finished.emit(RUNNING)
	elif Input.is_action_just_pressed("right_" + str(samus.player_index)):
		if samus.looking == samus.look_directions.LEFT:
			pass
		else:
			finished.emit(RUNNING)
	elif Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		if Input.is_action_pressed("left_" + str(samus.player_index)) or Input.is_action_pressed("right_" + str(samus.player_index)):
			finished.emit(RUNNING)
		elif Input.is_action_just_pressed("down_" + str(samus.player_index)) and samus.aiming_down:
			print("aiming_down: " + str(samus.aiming_down))
			print("aiming down and just pressed down, should crouch") 
			finished.emit(CROUCHING)
		else:
			handle_diagonal_aiming("stand")
	elif Input.is_action_just_released("diagonal_aim_" + str(samus.player_index)):
		samus.aiming_down = false
		samus.animation_player.play("stand_" + samus.look_direction)
	elif Input.is_action_just_pressed("down_" + str(samus.player_index)):
		finished.emit(CROUCHING)
	elif Input.is_action_pressed("up_" + str(samus.player_index)):
		samus.animation_player.play("stand_aim_up_" + samus.look_direction)
	elif Input.is_action_just_released("up_" + str(samus.player_index)):
		samus.animation_player.play("stand_" + samus.look_direction)
		
	if not samus.is_on_floor():
		finished.emit(FALLING)


func exit() -> void:
	samus.idle_timer.stop()
