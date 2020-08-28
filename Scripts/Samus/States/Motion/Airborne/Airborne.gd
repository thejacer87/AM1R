extends MotionState

class_name AirborneState

var max_jump_velocity
var min_jump_velocity

func _ready() -> void:
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)

func handle_input(event):
	return .handle_input(event)
