class_name MainCamera
extends Camera2D

signal transition_completed(samus)

var _samus
var _left
var _right
var _top
var _bottom
var _exit

onready var _tween := $Tween

func transition(bounds : Array, exit : Position2D) -> void:
	_samus = Globals.Samus
	_top = bounds[0]
	_right = bounds[1]
	_bottom = bounds[2]
	_left = bounds[3]
	_exit = exit

	# Pause player processing (physics and input processing, animations, state
	# timers, etc.)
	get_tree().paused = true
	# Disable smoothing to avoid jitter during transition.
	self.smoothing_enabled = false

	_interpolate_camera_pos()

	yield(_tween, 'tween_completed')
	# Re-enable smoothing now that the transition has completed.
	self.smoothing_enabled = true

	# Restore processing.
	get_tree().paused = false

	emit_signal('transition_completed', _samus)


func _interpolate_camera_pos() -> void:
	var duration := 0.66
	var offset_x := Globals.SCREEN_WIDTH / 2
	var offset_y := Globals.SCREEN_HEIGHT / 2
	var trans := Tween.TRANS_LINEAR
	var easing := Tween.EASE_IN_OUT

	_tween.stop_all()
	_tween.interpolate_property(_samus, "position:x", _samus.position.x, _exit.global_position.x, duration, trans, easing)

	# Move the camera limits to the edges
	# right to left smoothness might have somethign to do with this...
	_tween.interpolate_property(self, "limit_left", max(self.limit_left, self.global_position.x - offset_x), _left.global_position.x, duration, trans, easing)
	_tween.interpolate_property(self, "limit_right", min(self.limit_right, self.global_position.x + offset_x), _right.global_position.x, duration, trans, easing)
	_tween.interpolate_property(self, "limit_top", min(self.limit_top, self.global_position.y - offset_y), _top.global_position.y, duration, trans, easing)
	_tween.interpolate_property(self, "limit_bottom", max(self.limit_bottom, self.global_position.y + offset_y), _bottom.global_position.y, duration, trans, easing)
	_tween.start()
