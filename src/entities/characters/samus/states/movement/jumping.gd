extends BaseMovement
# SpinJumping and Jumping are essentially the same, make sure to duplicate any
# changes necessary.


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.y = samus.MAX_JUMP_VELOCITY
	samus.animation_player.play("jump_up_" + look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x * 0.6667
	samus.move_and_slide()

	if samus.velocity.y >= 0:
		finished.emit(FALLING) # Only difference with Spin Jumping

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
		
	if Input.is_action_just_released("jump_" + str(samus.player_index)):
		print("stopping jump")
		if samus.velocity.y < samus.MIN_JUMP_VELOCITY:
			samus.velocity.y = 0     
		else: 
			samus.velocity.y = 0
