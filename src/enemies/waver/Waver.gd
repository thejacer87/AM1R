class_name Waver
extends Enemy

const SPEED_HORIZONTAL := 75
const SPEED_VERTICAL := 50

var velocity := Vector2.ZERO

var _direction_horizontal: int = Globals.Directions.LEFT
var _direction_vertical: int = Globals.Directions.UP

onready var animated_sprite := $AnimatedSprite


func _move(_delta: float) -> void:
	if is_on_floor():
		_direction_vertical = Globals.Directions.UP
		velocity.y *= -1
	if is_on_ceiling():
		_direction_vertical = Globals.Directions.DOWN
		velocity.y *= -1
	if is_on_wall():
		_direction_horizontal *= -1
		velocity.x *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h

	var motion = Vector2(_direction_horizontal * SPEED_HORIZONTAL, _direction_vertical * SPEED_VERTICAL)
	velocity = motion
	velocity = move_and_slide(velocity, Vector2.UP)
