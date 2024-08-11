extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("crouch")
	samus.velocity.x = 0.0
	samus.animation_player.play("crouch")


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("up_" + str(samus.player_index)):
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("morph_" + str(samus.player_index)) or Input.is_action_just_pressed("down_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif Input.is_action_just_pressed("left_" + str(samus.player_index)):
		if samus.looking == samus.look_directions.LEFT:
			finished.emit(RUNNING)
		else:
			turn_around()
	elif Input.is_action_just_pressed("right_" + str(samus.player_index)):
		if samus.looking == samus.look_directions.RIGHT:
			finished.emit(RUNNING)
		else:
			turn_around()
	elif Input.is_action_pressed("left_" + str(samus.player_index)):
		if samus.crouch_run_timer.time_left == 0 and samus.looking == samus.look_directions.LEFT:
			finished.emit(RUNNING)
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		if samus.crouch_run_timer.time_left == 0 and samus.looking == samus.look_directions.RIGHT:
			finished.emit(RUNNING)

func exit() -> void:
	super.exit()
	super.update_collisions("")


func turn_around() -> void:
	samus.looking = -samus.looking
	samus.crouch_run_timer.start()
