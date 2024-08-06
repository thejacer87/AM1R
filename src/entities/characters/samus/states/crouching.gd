extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	super.update_collisions("crouch")
	samus.velocity.x = 0.0
	samus.animated_sprite_2d.play("crouch")


func physics_update(delta: float) -> void:
	super.physics_update(delta)

	if Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("up_" + str(samus.player_index)):
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("morph_" + str(samus.player_index)) or Input.is_action_just_pressed("down_" + str(samus.player_index)):
		finished.emit(MORPHING)
	elif Input.is_action_pressed("left_" + str(samus.player_index)) or Input.is_action_pressed("right_" + str(samus.player_index)):
		finished.emit(RUNNING)


func exit() -> void:
	super.exit()
	super.update_collisions("")
