extends AirborneState

class_name JumpState

var enter_velocity := Vector2.ZERO

func initialize(velocity: Vector2):
	enter_velocity = velocity


func enter():
	var input_direction = get_input_direction()

	if input_direction:
		velocity = enter_velocity 
		if morph_state_machine.current_state != morph_state_machine.states_map["morph_ball"]:
			animation_state.travel("SpinJump")
	else:
		velocity = Vector2.ZERO
		animation_state.travel("Jump")
	
	velocity.y = max_jump_velocity

func handle_input(event: InputEvent):
	if event.is_action_released("jump") && velocity.y < min_jump_velocity:
		velocity.y = min_jump_velocity

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction:
		animation_tree.set(blend % "SpinJump", input_direction)
		animation_tree.set(blend % "Jump", input_direction)
		if sign(velocity.x) != sign(input_direction.x): 
			velocity.x = aerial_speed * sign(input_direction.x)
			
	if velocity.y >= 0 and owner.is_on_floor():
		animation_state.travel("Move")
		emit_signal("finished", "previous")

	.apply_gravity(delta)
	.apply_movement()
