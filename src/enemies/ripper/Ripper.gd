class_name Ripper
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
	pass
