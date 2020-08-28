extends AirborneState

class_name JumpState


#func initialize(speed, velocity):
#	pass
#	horizontal_speed = speed
#	max_horizontal_speed = speed if speed > 0.0 else BASE_MAX_HORIZONTAL_SPEED
#	enter_velocity = velocity


func enter():
	animation_state.travel("SpinJump")

func handle_input(event: InputEvent):
		if event.is_action_pressed("jump"):
#			todo not high enough to get off the ground!??!
			velocity.y = max_jump_velocity
#	#	if [states.idle, states.run].has(state):
##
##	if [states.jump, states.spin_jump].has(state):
##		if event.is_action_released("jump") && parent.velocity.y < parent.min_jump_velocity:
##			parent.velocity.y = parent.min_jump_velocity

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	animation_tree.set(blend % "Jump", input_direction)
	if velocity.y >= 0 and owner.is_on_floor():
		emit_signal("finished", "previous")

	.apply_gravity(delta)
	.apply_movement()
