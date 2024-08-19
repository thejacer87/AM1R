extends BaseMovement
# SpinFalling and Falling are essentially the same, make sure to duplicate any
# changes necessary.
var wall_direction := 0

func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var current_animation := samus.animation_player.current_animation
	
	samus.animation_player.play("jump_" + samus.look_direction)


func physics_update(delta: float) -> void:
#	Check wall direction first before super has a chance to change the looking direction. 
	if samus.is_on_wall():
		wall_direction = samus.looking
		if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
			print('wall jumped!')
			samus.wall_jump_timer.start()
			samus.wall_jump(wall_direction)
			samus.animation_player.play("jump_" + samus.look_direction)
			
	samus.velocity.y = min(samus.velocity.y + samus.GRAVITY * delta, samus.MAX_FALL_SPEED)

	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	
	samus.move_and_slide()
	
	if samus.wall_jump_timer.time_left <= 0:
		print("checking left right")
		
		if not input_direction_x == 0:
			samus.velocity.x = samus.SPEED * input_direction_x
		if Input.is_action_pressed("left_" + str(samus.player_index)):
			samus.looking = samus.look_directions.LEFT
			samus.animation_player.play("jump_" + samus.look_direction)
		if Input.is_action_pressed("right_" + str(samus.player_index)):
			samus.looking = samus.look_directions.RIGHT
			samus.animation_player.play("jump_" + samus.look_direction)
		
	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)

	if Input.is_action_just_pressed("fire_" + str(samus.player_index)):
		samus.velocity = Vector2.ZERO
		finished.emit(FALLING)
		
	if samus.is_on_floor():
		if is_equal_approx(samus.velocity.x, 0.0):
			finished.emit(IDLE, {"look_direction": samus.look_direction})
		else:
			finished.emit(RUNNING)
