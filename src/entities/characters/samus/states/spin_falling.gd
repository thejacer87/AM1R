extends BaseMovement
# SpinFalling and Falling are essentially the same, make sure to duplicate any
# changes necessary.
var wall_direction := 0

func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var current_animation := samus.animation_player.current_animation
	
	samus.animation_player.play("jump_" + look_direction)


func physics_update(delta: float) -> void:
#	Check wall direction first before super has a chance to change the looking direction. 
	if samus.is_on_wall():
		wall_direction = samus.looking
	super.physics_update(delta)

	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	if not input_direction_x == 0:
		samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()
	
	handle_wall_jump()
		
	if Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)

	if Input.is_action_just_pressed("fire_" + str(samus.player_index)):
		samus.velocity = Vector2.ZERO
		finished.emit(FALLING)	
		
	if samus.is_on_floor():
		if is_equal_approx(samus.velocity.x, 0.0):
			finished.emit(IDLE, {"look_direction": look_direction})
		else:
			finished.emit(RUNNING)


func handle_wall_jump() -> void:				  		
	if Input.is_action_just_pressed("left_" + str(samus.player_index)):
		print('pressed left. wall direction: ' + str(wall_direction))
		if wall_direction == samus.look_directions.RIGHT:
			print('wall direction is right: ' + str(wall_direction))
			samus.wall_jump_timer.start()
	if Input.is_action_just_pressed("right_" + str(samus.player_index)):
		print('pressed right. wall direction: ' + str(wall_direction))
		if wall_direction == samus.look_directions.LEFT:
			print('wall direction is left: ' + str(wall_direction))
			samus.wall_jump_timer.start()
			
	if Input.is_action_just_pressed("jump_" + str(samus.player_index)) and samus.wall_jump_timer.time_left > 0:
		print('jumped!')
		samus.wall_jump(wall_direction)
		
	
