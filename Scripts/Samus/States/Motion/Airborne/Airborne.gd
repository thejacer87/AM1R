extends MotionState

class_name AirborneState

var max_jump_velocity
var min_jump_velocity
var aerial_speed : float = 10 * Globals.UNIT_SIZE
var enter_velocity := Vector2.ZERO

func initialize(velocity: Vector2) -> void:
	enter_velocity = velocity


func _ready() -> void:
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)
