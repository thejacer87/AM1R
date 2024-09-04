class_name MainCamera
extends Camera2D

enum Bounds {TOP, BOTTOM, LEFT, RIGHT}

func set_camera_bounds(room: Room) -> void:
	var camera_bounds := room.camera_bounds.get_children()

	limit_top = (camera_bounds[Bounds.TOP] as Marker2D).global_position.y
	limit_right = (camera_bounds[Bounds.RIGHT] as Marker2D).global_position.x
	limit_bottom = (camera_bounds[Bounds.BOTTOM] as Marker2D).global_position.y
	limit_left = (camera_bounds[Bounds.LEFT] as Marker2D).global_position.x
	position = Vector2.ZERO
