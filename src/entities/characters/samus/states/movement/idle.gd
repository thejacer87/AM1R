class_name Idle
extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.x = 0.0
	var animation := "idle_" + look_direction
	samus.animated_sprite_2d.play(animation)


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	samus.velocity.y += samus.GRAVITY * delta
	samus.move_and_slide()

	if not samus.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("left_" + str(samus.player_index)):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		finished.emit(RUNNING)
