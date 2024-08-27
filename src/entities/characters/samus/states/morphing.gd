extends BaseMovement

var AIR_SPEED_MULTIPLIER := 0.95
var GROUND_SPEED_MULTIPLIER := 1.2

func enter(previous_state_path: String, data := {}) -> void:
	if not samus.has_power_item_activated("maru_mari"):
		finished.emit(previous_state_path)
		return
	super.enter(previous_state_path, data)
	super.update_collisions("morph")
	samus.animation_player.play("morphing")
	samus.animation_player.queue("morph_ball")


func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("left_" + str(samus.player_index), "right_" + str(samus.player_index))
	
	samus.velocity.x = samus.SPEED * input_direction_x * (GROUND_SPEED_MULTIPLIER if samus.is_on_floor() else AIR_SPEED_MULTIPLIER)
	samus.move_and_slide()

	if Input.is_action_just_pressed("morph_" + str(samus.player_index)) or Input.is_action_just_pressed("up_" + str(samus.player_index)):
		if not samus.is_on_floor():
			finished.emit(FALLING)
		else:
			finished.emit(CROUCHING)


func exit() -> void:
	super.exit()
	super.update_collisions("")
