class_name Zeb
extends Enemy

const SPEED := 150
const DURATION := 2.0

var velocity := Vector2.ZERO

var _direction := -1
var _attacking := false
var _max_height := Globals.SCREEN_HEIGHT * 0.75

onready var _tween := $Tween
onready var raycast := $RayCast2D
onready var animated_sprite := $AnimatedSprite

func regenerate() -> void:
	.regenerate()
	_attacking = false
	_ascend()


func _move(delta: float) -> void:
	if _attacking:
		_tween.stop_all()
		velocity = Vector2(SPEED * _direction, 0)
		velocity = move_and_slide(velocity)
	else:
		if raycast.is_colliding():
			_detect()

		yield(_tween, "tween_completed")
		_attacking = true


func _ascend() -> void:
	_update_direction()
	_tween.stop_all()
	_tween.interpolate_property(self, "position:y", position.y, position.y - _max_height, DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()


func _update_direction() -> void:
	var direction_to_samus = to_local(Globals.Samus.global_position)
	_direction = 1 if direction_to_samus.x > 0 else -1
	animated_sprite.flip_h = direction_to_samus.x > 0
	raycast.rotation_degrees = 270 if direction_to_samus.x > 0 else 90


func _detect() -> void:
	_attacking = true


func _on_VisibilityEnabler2D_screen_exited() -> void:
	die(false)


func _on_VisibilityEnabler2D_screen_entered() -> void:
	_ascend()
