class_name MainCamera
extends Camera2D

signal transition_completed

enum Bounds {TOP, RIGHT, BOTTOM, LEFT}

var _samus: Samus
var _is_moving_left

onready var _tween: Tween = $Tween


func transition(old_room, new_room, door, left = true) -> void:
	_samus = Globals.Samus
	_is_moving_left = left
	_transition_setup()

	_interpolate_camera_pos(old_room, new_room, door)

	yield(_tween, 'tween_started')
	_remove_camera_limits()

	yield(_tween, 'tween_completed')
	_transition_teardown(new_room)

	emit_signal('transition_completed')


func _transition_setup():
	get_tree().paused = true
	self.smoothing_enabled = false


func _transition_teardown(room) -> void:
	_set_camera_bounds(room)
	self.smoothing_enabled = true
	get_tree().paused = false


func _set_camera_bounds(room) -> void:
	var camera_bounds = room.get_node("CameraBounds").get_children()

	self.limit_top = camera_bounds[Bounds.TOP].global_position.y
	self.limit_right = camera_bounds[Bounds.RIGHT].global_position.x
	self.limit_bottom = camera_bounds[Bounds.BOTTOM].global_position.y
	self.limit_left = camera_bounds[Bounds.LEFT].global_position.x
	self.position = Vector2.ZERO


func _interpolate_camera_pos(old_room, new_room, door) -> void:
	var duration := 0.66
	var trans := Tween.TRANS_LINEAR
	var easing := Tween.EASE_OUT
	var old := "Left" if _is_moving_left else "Right"
	var new := "Right" if _is_moving_left else "Left"

	var anchor_pos_old: Vector2 = door.get_node(old + "/CameraAnchor").global_position
	var anchor_pos_new: Vector2 = door.get_node(new + "/CameraAnchor").global_position
	var samus_new := Vector2(door.get_node(old + "/Exit").global_position.x, _samus.global_position.y)

	_tween.stop_all()
	_tween.interpolate_property(self, "global_position", anchor_pos_old, anchor_pos_new, duration, trans, easing)
	_tween.interpolate_property(_samus, "global_position", _samus.global_position, samus_new, duration, trans, easing)
	_tween.start()


func _remove_camera_limits() -> void:
	self.limit_left = -10000000
	self.limit_right = 10000000
	self.limit_top = -10000000
	self.limit_bottom = 10000000
