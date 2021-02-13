class_name Zeb
extends Enemy

const SPEED := 150
const DURATION := 3.0

var velocity := Vector2.ZERO

var _direction
var _attacking := false
var _max_height := Globals.SCREEN_HEIGHT * 0.75

onready var _tween := $Tween
onready var animated_sprite := $AnimatedSprite
onready var raycast_left := $LeftRayCast2D
onready var raycast_right := $RightRayCast2D


func _physics_process(delta: float) -> void:
	if _direction == null:
		var direction_to_samus = self.to_local(Globals.Samus.global_position)
		_direction = -1 if direction_to_samus.x <= 0 else 1
		_disable_raycast()
		animated_sprite.flip_h = _direction <= 0


func _move(delta: float) -> void:
	if _attacking:
		_tween.stop_all()
		velocity = Vector2(SPEED * _direction, 0)
		velocity = move_and_slide(velocity)
	else:
		if raycast_left.is_colliding() or raycast_right.is_colliding():
			_detect()

		yield(_tween, "tween_completed")
		_attacking = true


func _detect() -> void:
	_attacking = true


func _disable_raycast() -> void:
	if _direction == DirectionsX.LEFT:
		raycast_right.set_deferred("enabled", false)
	else:
		raycast_left.set_deferred("enabled", false)


func _die(drop_item := true) -> void:
	if drop_item:
		_drop_item()
	queue_free()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	if _attacking:
		queue_free()


func _on_VisibilityEnabler2D_screen_entered() -> void:
	_tween.stop_all()
	_tween.interpolate_property(self, "position:y", position.y, position.y - _max_height, DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
