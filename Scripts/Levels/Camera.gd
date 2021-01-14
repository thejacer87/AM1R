extends Camera2D

class_name MainCamera


onready var _tween := $Tween
onready var _black_layer := $BlackLayer/ColorRect

var samus

signal transition_completed


func transition(samus: Samus, left : Position2D, right : Position2D, top : Position2D, bottom : Position2D, exit : Position2D) -> void:
	self.samus = samus
	_transition_setup()

	_interpolate_camera_pos(exit)

	# Remove camera limits so that camera can smoothly transition between rooms.
	# Note that we wait until the tween has started to avoid jitter when the
	# camera moves from the player anchor to the initial tween position.
	yield(_tween, 'tween_started')
	_remove_camera_limits()

	yield(_tween, 'tween_completed')
	_transition_teardown(left, right, top, bottom, exit)

	emit_signal('transition_completed')


func _transition_setup() -> void:
	# Pause player processing (physics and input processing, animations, state
	# timers, etc.)
	get_tree().paused = true

#	_black_layer.visible = true

	# Disable smoothing to avoid jitter during transition.
	self.smoothing_enabled = false


func _transition_teardown(left : Position2D, right : Position2D, top : Position2D, bottom : Position2D, exit : Position2D) -> void:
	# Re-enable smoothing now that the transition has completed.
	self.smoothing_enabled = true

	_set_camera_limits(left, right, top, bottom)
	samus.position.x = exit.global_position.x
	_black_layer.visible = false

	# Restore processing.
	get_tree().paused = false


func _interpolate_camera_pos(anchor : Position2D) -> void:
	var prop := "position"
	var duration := 0.75
	var trans := Tween.TRANS_LINEAR
	var easing := Tween.EASE_OUT_IN

	_tween.stop_all()
	_tween.interpolate_property(self, prop, self.position, anchor.position, duration, trans, easing)
#	_tween.interpolate_property(samus, prop, samus.global_position, anchor.global_position, duration, trans, easing)
	_tween.start()


func _set_camera_limits(left : Position2D, right : Position2D, top : Position2D, bottom : Position2D) -> void:
	self.limit_left = left.global_position.x
	self.limit_right = right.global_position.x
	self.limit_top = top.global_position.y
	self.limit_bottom = bottom.global_position.y


func _remove_camera_limits() -> void:
	self.limit_left = -10000000
	self.limit_right = 10000000
	self.limit_top = -10000000
	self.limit_bottom = 10000000
