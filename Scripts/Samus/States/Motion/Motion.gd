extends State

class_name MotionState

#func handle_input(event):
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")

func get_input_direction():
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
	if not direction.x in [-1, 1]:
		return
#	owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))
