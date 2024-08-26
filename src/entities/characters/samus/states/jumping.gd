extends BaseMovement
# SpinJumping and Jumping are essentially the same, make sure to duplicate any
# changes necessary.


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.y = samus.MAX_JUMP_VELOCITY * (samus.HIGH_JUMP_MULTIPLIER if samus.has_power_item_activated("high_jump") else 1.0)
	var animation := "jump_up_"
	if samus.is_aiming and Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
			animation += "aim_diag_" + ("down_" if samus.aiming_down else "up_")
	print("animation: " + animation)
	samus.animation_player.play(animation + samus.look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	if samus.velocity.y >= 0:
		finished.emit(FALLING)

	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	var input_direction_y := Input.get_axis("up_" + str(samus.player_index), "down_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x * 0.6667   
	samus.move_and_slide()
		
	if Input.is_action_just_pressed("left_" + str(samus.player_index)):
		samus.animation_player.play("jump_up_" + samus.look_direction)
	if Input.is_action_just_pressed("right_" + str(samus.player_index)):
		samus.animation_player.play("jump_up_" + samus.look_direction)

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif (not input_direction_y == 0 and not input_direction_x == 0) or Input.is_action_pressed("diagonal_aim_" + str(samus.player_index)):
		handle_diagonal_aiming("jump_up")
	elif Input.is_action_just_released("diagonal_aim_" + str(samus.player_index)):
		samus.aiming_down = false
		samus.animation_player.play("jump_up_" + samus.look_direction)
	elif Input.is_action_pressed("up_" + str(samus.player_index)):
		samus.animation_player.play("jump_up_aim_up_" + samus.look_direction)
	elif Input.is_action_pressed("down_" + str(samus.player_index)):
		print("aim straight down")
		samus.animation_player.play("jump_up_aim_down_" + samus.look_direction)
		
	if Input.is_action_just_released("jump_" + str(samus.player_index)):
		print("stopping jump")
		if samus.velocity.y < samus.MIN_JUMP_VELOCITY:
			samus.velocity.y = 0     
		else: 
			samus.velocity.y = 0
			
