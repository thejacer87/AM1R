extends State

class_name ModeState


func handle_input(event):
	return .handle_input(event)


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func update(delta):
	var input_direction = get_input_direction()
	owner.get_node("AnimationTree").set(owner.blend % owner.travel, input_direction)
