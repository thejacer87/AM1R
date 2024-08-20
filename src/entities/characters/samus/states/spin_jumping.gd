extends BaseMovement
# SpinJumping and Jumping are essentially the same, make sure to duplicate any
# changes necessary.

func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("spin")
	samus.sprite_2d.position.y = 0.0
	samus.velocity.y = samus.MAX_JUMP_VELOCITY
	samus.animation_player.play("jump_" + samus.look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	if not input_direction_x == 0:
		samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()
	
	if Input.is_action_just_pressed("left_" + str(samus.player_index)):
		samus.animation_player.play("jump_" + samus.look_direction)
	if Input.is_action_just_pressed("right_" + str(samus.player_index)):
		samus.animation_player.play("jump_" + samus.look_direction)

	if samus.velocity.y >= 0:
		finished.emit(SPIN_FALLING)

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
		
	if Input.is_action_just_pressed("up_" + str(samus.player_index)):
		samus.velocity.x = 0
		finished.emit(FALLING)
		
	if Input.is_action_just_pressed("down_" + str(samus.player_index)):
		samus.velocity.x = 0
		finished.emit(FALLING)
	
	if Input.is_action_just_pressed("fire_" + str(samus.player_index)):
		samus.velocity = Vector2.ZERO
		finished.emit(FALLING)
 			
	if Input.is_action_just_released("jump_" + str(samus.player_index)):
		# This isn't really working... would like the min jump to be two units high.
		if samus.velocity.y < samus.MIN_JUMP_VELOCITY:
			samus.velocity.y = 0
		else:
			samus.velocity.y = 0
			 

func exit() -> void:
	super.exit()
	samus.sprite_2d.position.y = -8.0
	super.update_collisions("")
