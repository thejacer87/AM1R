class_name MainCamera
extends Camera2D

signal transition_completed

enum Bounds {TOP, RIGHT, BOTTOM, LEFT}

const TRANSITION_DURATION := 1.5

var _is_moving_left

onready var _samus: Samus = get_parent()
onready var _tween := $Tween


func transition(old_room, new_room, door, direction) -> void:
	_transition_setup()

	var door_exit = "Left/Exit"
	var camera_anchor_old = "Left/CameraAnchor"
	var camera_anchor_new = "Right/CameraAnchor"
	if not direction == Vector2.RIGHT:
		door_exit = "Right/Exit"
		camera_anchor_old = "Right/CameraAnchor"
		camera_anchor_new = "Left/CameraAnchor"

	var duration = TRANSITION_DURATION
	var anchor_pos_old: Vector2 = self.to_local(door.get_node(camera_anchor_old).global_position)
	var anchor_pos_new: Vector2 = self.to_local(door.get_node(camera_anchor_new).global_position)

	if not anchor_pos_old.y == anchor_pos_new.y:
		# Only take a small portion of the total time to transition for vertical change.
		var height_diff = min(abs(anchor_pos_old.y - anchor_pos_new.y) / Globals.SCREEN_HEIGHT, 0.35)
		var height_duration = TRANSITION_DURATION * height_diff
		duration = TRANSITION_DURATION - height_duration

		_interpolate_camera_pos("position:y", anchor_pos_old.y, anchor_pos_new.y, height_duration)
		yield(_tween, 'tween_started')
		_remove_camera_y_limits()
		yield(_tween, 'tween_completed')

	_interpolate_camera_pos("position:x", anchor_pos_old.x, anchor_pos_new.x, duration)
	yield(_tween, 'tween_started')
	_remove_camera_x_limits()
	yield(_tween, 'tween_completed')

	_samus.global_position = Vector2(door.get_node(door_exit).global_position.x, _samus.global_position.y)

	_transition_teardown(new_room)

	emit_signal('transition_completed')


func set_camera_bounds(room: Room) -> void:
	var camera_bounds = room.camera_bounds.get_children()

	self.limit_top = camera_bounds[Bounds.TOP].global_position.y
	self.limit_right = camera_bounds[Bounds.RIGHT].global_position.x
	self.limit_bottom = camera_bounds[Bounds.BOTTOM].global_position.y
	self.limit_left = camera_bounds[Bounds.LEFT].global_position.x
	self.position = Vector2.ZERO


func _transition_setup():
	self.smoothing_enabled = false


func _transition_teardown(room) -> void:
	set_camera_bounds(room)
	self.smoothing_enabled = true


func _interpolate_camera_pos(property, anchor_pos_old, anchor_pos_new, duration) -> void:
	_tween.stop_all()
	_tween.interpolate_property(self, property, anchor_pos_old, anchor_pos_new, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()


func _remove_camera_x_limits() -> void:
	self.limit_left = -10000000
	self.limit_right = 10000000


func _remove_camera_y_limits() -> void:
	self.limit_top = -10000000
	self.limit_bottom = 10000000
