class_name Idle
extends BaseMovement


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path, data)
	samus.velocity.x = 0.0
	var animation := "stand_" + look_direction
	samus.animation_player.play(animation)
	samus.idle_timer.start()


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	#samus.move_and_slide()
	#if samus.idle_timer.time_left == 0:
		#samus.animation_player.play("idle_" + look_direction)

	if Input.is_action_just_pressed("down_" + str(samus.player_index)):
		finished.emit(CROUCHING)
	elif Input.is_action_just_pressed("jump_" + str(samus.player_index)):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("left_" + str(samus.player_index)):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed("morph_" + str(samus.player_index)):
		finished.emit(MORPHING)
		
	if not samus.is_on_floor():
		finished.emit(FALLING)


func exit() -> void:
	samus.idle_timer.stop()
