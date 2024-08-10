extends BaseMovement
# SpinFalling and Falling are essentially the same, make sure to duplicate any
# changes necessary.

func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var current_animation := samus.animation_player.current_animation
	
	samus.animation_player.play("jump_" + look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	if not input_direction_x == 0:
		samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()
	
	if Input.is_action_just_pressed("jump_" + str(samus.player_index)) and samus.wall_stick_timer.time_left > 0:
		print("wall_jump")
		var wall_direction := -samus.looking
		if true:
			print("wall_jump 2")
			samus.looking = -samus.looking
			samus.velocity.x = 1.75 * wall_direction * samus.WALL_JUMP_SPEED
			samus.velocity.y = samus.MAX_JUMP_VELOCITY * 0.8
		
	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)

	if samus.is_on_floor():
		if is_equal_approx(samus.velocity.x, 0.0):
			finished.emit(IDLE, {"look_direction": look_direction})
		else:
			finished.emit(RUNNING)

	if samus.is_on_wall():
		samus.wall_stick_timer.start()
