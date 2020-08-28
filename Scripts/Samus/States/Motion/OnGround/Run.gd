extends OnGroundState

class_name RunState

var run_speed : float = 10 * Globals.UNIT_SIZE

func enter():
	speed = 0.0
	velocity = Vector2.ZERO

	var input_direction = get_input_direction()
	animation_state.travel("Run")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")

	velocity.x = input_direction.x * run_speed
	apply_gravity(delta)
	apply_movement()

	
#func _handle_move_input() -> void:
#	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
#	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
#	input = input.normalized()
#
#	if movement_sm.state.crouch:
#		velocity.x = 0
#	elif is_on_floor():
#		velocity.x = input.x * run_speed
#	elif is_on_floor():
#		velocity.x = input.x * run_speed
#	else:
#		pass
#
#	if input.x != 0:
#		animation_tree.set(blend % travel, input)
#
#	animation_state.travel(travel)
#
#
func apply_movement() -> void:
	velocity = owner.move_and_slide(velocity, FLOOR)
