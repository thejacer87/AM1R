extends AirborneState

class_name JumpState

const BASE_MAX_HORIZONTAL_SPEED := 400.0
var horizontal_speed := 0.0
var max_horizontal_speed = 0.00
var horizontal_velocity = Vector2.ZERO

var enter_velocity = Vector2.ZERO

func initialize(velocity):
	enter_velocity = velocity


func enter():
	var input_direction = get_input_direction()

	if input_direction:
		velocity = enter_velocity 
		animation_state.travel("SpinJump")
	else:
		velocity = Vector2.ZERO
		animation_state.travel("Jump")
	
	velocity.y = max_jump_velocity

#func handle_input(event: InputEvent):
#	if event.is_action_pressed("jump"):
##			todo not high enough to get off the ground!??!
#		velocity.y = max_jump_velocity

func update(delta: float) -> void:
	var input_direction = get_input_direction()
	var AAAAAAA = input_direction.dot(velocity.normalized())
	if input_direction:
		animation_tree.set(blend % "SpinJump", input_direction)
		animation_tree.set(blend % "Jump", input_direction)
		if sign(velocity.x) != sign(input_direction.x): 
			velocity.x = velocity.x * delta
			
	if velocity.y >= 0 and owner.is_on_floor():
		animation_state.travel("Move")
		emit_signal("finished", "previous")

	.apply_gravity(delta)
	.apply_movement()
