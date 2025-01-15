class_name PlayerCamera
extends Camera2D

func set_camera_bounds(room: Room) -> void:
	MetSys.get_current_room_instance().adjust_camera_limits(self)
