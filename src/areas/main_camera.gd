class_name MainCamera
extends Camera2D

enum Bounds {TOP, BOTTOM, LEFT, RIGHT}

func set_camera_bounds(room: Room) -> void:
	var camera_bounds := room.camera_bounds

	limit_top = (camera_bounds.top as Marker2D).global_position.y
	limit_bottom = (camera_bounds.bottom as Marker2D).global_position.y
	limit_left = (camera_bounds.left as Marker2D).global_position.x
	limit_right = (camera_bounds.right as Marker2D).global_position.x
	position = Vector2.ZERO
