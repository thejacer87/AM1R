extends BaseMovement
# SpinFalling and Falling are essentially the same, make sure to duplicate any
# changes necessary.
var wall_direction := 0

func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("spin")
	samus.sprite_2d.position.y = 0.0
	var current_animation := samus.animation_player.current_animation
	
	samus.animation_player.play("jump_" + samus.look_direction)


func physics_update(delta: float) -> void:
#	Check wall direction first before super has a chance to change the looking direction. 
	
	if samus.is_colliding_with_wall():
		wall_direction = samus.looking
		if wall_direction == samus.look_directions.LEFT and Input.is_action_just_pressed("right_" + str(samus.player_index)):
			samus.wall_jump_timer.start()
		elif wall_direction == samus.look_directions.RIGHT and Input.is_action_just_pressed("left_" + str(samus.player_index)):
			samus.wall_jump_timer.start()
			
	super.physics_update(delta)
	if samus.wall_jump_timer.time_left > 0 and Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		samus.wall_jump(wall_direction)
		samus.animation_player.play("jump_" + samus.look_direction)

	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	if not input_direction_x == 0:
		samus.velocity.x = samus.SPEED * input_direction_x
	samus.move_and_slide()
	
	if Input.is_action_just_pressed("left_" + str(samus.player_index)):
		samus.animation_player.play("jump_" + samus.look_direction)
	if Input.is_action_just_pressed("right_" + str(samus.player_index)):
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


func exit() -> void:
	super.exit()
	samus.sprite_2d.position.y = -8.0
	super.update_collisions("")
