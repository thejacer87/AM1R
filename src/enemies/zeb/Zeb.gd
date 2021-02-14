class_name Zeb
extends Enemy

enum Rotations { LEFT = 90, RIGHT= 270 }

const SPEED := 175
const DURATION := 1.75

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
	raycast.rotation_degrees = Rotations.RIGHT if direction_to_samus.x > 0 else Rotations.LEFT


func _detect() -> void:
	_tween.stop_all()
	animated_sprite.speed_scale = 2
	yield(get_tree().create_timer(0.15), "timeout")
	_attacking = true


func _on_VisibilityEnabler2D_screen_exited() -> void:
	die(false)
	animated_sprite.speed_scale = 1


func _on_VisibilityEnabler2D_screen_entered() -> void:
	_ascend()
