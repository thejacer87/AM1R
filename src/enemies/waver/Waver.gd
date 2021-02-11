class_name Waver
extends Enemy

enum DirectionsX {LEFT = -1, RIGHT = 1}
enum DirectionsY {UP = -1, DOWN = 1}

const SPEED_HORIZONTAL := 125
const SPEED_VERTICAL := 100

var velocity := Vector2.ZERO

var _direction_horizontal: int = DirectionsX.LEFT
var _direction_vertical: int = DirectionsY.UP

onready var animated_sprite := $AnimatedSprite

func _move(_delta: float) -> void:
	if is_on_floor():
		_direction_vertical = DirectionsY.UP
		velocity.y *= -1
	if is_on_ceiling():
		_direction_vertical = DirectionsY.DOWN
		velocity.y *= -1
	if is_on_wall():
		_direction_horizontal *= -1
		velocity.x *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h


	var motion = Vector2(_direction_horizontal * SPEED_HORIZONTAL, _direction_vertical * SPEED_VERTICAL)
	velocity = motion
	velocity = move_and_slide(velocity, Vector2.UP)

