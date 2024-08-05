extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.y = samus.JUMP_VELOCITY
	samus.animated_sprite_2d.play("jump_spin_" + look_direction)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	samus.velocity.x = samus.SPEED * input_direction_x

	samus.velocity.y += samus.GRAVITY * delta
	samus.move_and_slide()

	if samus.velocity.y >= 0:
		finished.emit(FALLING)
