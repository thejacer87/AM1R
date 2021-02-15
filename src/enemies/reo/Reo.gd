class_name Reo
extends Enemy

const SPEED_HORIZONTAL := 50
const SPEED_VERTICAL := 200

var velocity := Vector2.ZERO

var _attacking := false
var _direction_horizontal: int = Globals.DIRECTIONS.LEFT
var _direction_vertical: int = Globals.DIRECTIONS.DOWN

onready var detection_left := $LeftDetection/CollisionShape2D
onready var detection_right := $RightDetection/CollisionShape2D


func _ready() -> void:
	pass


func _move(_delta: float) -> void:
	if _attacking:
		var motion = Vector2(_direction_horizontal * SPEED_HORIZONTAL, _direction_vertical * SPEED_VERTICAL)
		velocity = motion
		velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_ceiling():
		_attacking = false
		velocity = Vector2.ZERO
		_direction_vertical = Globals.DIRECTIONS.DOWN
		yield(get_tree().create_timer(.5), "timeout")
		_enable_detections()
	if is_on_floor():
		_direction_vertical = Globals.DIRECTIONS.UP


func _detect(direction: int) -> void:
	_disable_detections()
	_direction_horizontal = direction
	_attacking = true


func _disable_detections() -> void:
	detection_left.set_deferred("disabled", true)
	detection_right.set_deferred("disabled", true)


func _enable_detections() -> void:
	detection_left.set_deferred("disabled", false)
	detection_right.set_deferred("disabled", false)


func _on_LeftDetection_body_entered(_body: Node) -> void:
	_detect(Globals.DIRECTIONS.LEFT)


func _on_RightDetection_body_entered(_body: Node) -> void:
	_detect(Globals.DIRECTIONS.RIGHT)
