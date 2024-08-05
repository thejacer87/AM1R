extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	var animation := "run_" + look_direction
	samus.animated_sprite_2d.play(animation)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x
	samus.velocity.y += samus.GRAVITY * delta
	samus.move_and_slide()

	if not samus.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE, {"look_direction": look_direction})
