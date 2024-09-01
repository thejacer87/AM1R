extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("crouch")
	samus.velocity.x = 0.0
	var animation := "crouch_"
	if samus.is_aiming and Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		animation += "aim_diag_" + ("down_" if samus.aiming_down else "up_")
	print(animation + samus.look_direction)
	samus.animation_player.play(animation + samus.look_direction)


func physics_update(delta: float) -> void:
	#todo when a frozen enemy unfreezes while samus is crouching on it, samus stays floating. that was seemingly fixed in idle.gd by adding move_and_slide(), but not here. might be moot since when the enemy unfreezes samus, it should hurt her, sending her into a hurt state, then fall
	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif Input.is_action_just_pressed("left_" + str(samus.player_index)):
		if samus.looking == samus.look_directions.LEFT:
			finished.emit(RUNNING)
		else:
			turn_around("left")
	elif Input.is_action_just_pressed("right_" + str(samus.player_index)):
		if samus.looking == samus.look_directions.RIGHT:
			finished.emit(RUNNING)
		else:
			turn_around("right")
	elif Input.is_action_pressed("left_" + str(samus.player_index)):
		if samus.crouch_run_timer.time_left == 0 and samus.looking == samus.look_directions.LEFT:
			finished.emit(RUNNING)
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		if samus.crouch_run_timer.time_left == 0 and samus.looking == samus.look_directions.RIGHT:
			finished.emit(RUNNING)
	elif Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		if Input.is_action_pressed("left_" + str(samus.player_index)) or Input.is_action_pressed("right_" + str(samus.player_index)):
			finished.emit(RUNNING)
		elif Input.is_action_just_pressed("down_" + str(samus.player_index)) and samus.aiming_down:
			print("aiming_down: " + str(samus.aiming_down))
			print("aiming down and just pressed down, should morph and set aiming down to false ") 
			samus.aiming_down = false
			finished.emit(MORPHING)
		elif Input.is_action_just_pressed("up_" + str(samus.player_index)) and not samus.aiming_down:
			print("aiming_down: " + str(samus.aiming_down))
			print("aiming up and just pressed up, should stand") 
			finished.emit(IDLE)
		else:
			handle_diagonal_aiming("crouch")
	elif Input.is_action_just_released("diagonal_aim_" + str(samus.player_index)):
		samus.aiming_down = false
		samus.animation_player.play("crouch_" + samus.look_direction)
	elif Input.is_action_just_pressed("up_" + str(samus.player_index)):
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("down_" + str(samus.player_index)):
		finished.emit(MORPHING)


func exit() -> void:
	super.exit()
	super.update_collisions("")


func turn_around(direction: String) -> void:
	samus.looking = -samus.looking
	var animation := "crouch_"
	if samus.is_aiming and Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		animation += "aim_diag_" + ("down_" if samus.aiming_down else "up_")
	samus.animation_player.play(animation + samus.look_direction)
	samus.crouch_run_timer.start()
