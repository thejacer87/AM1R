extends StaticBody2D

export (NodePath) var left_room_path
export (NodePath) var right_room_path

onready var wall := $Wall
onready var left_door := $Left
onready var right_door := $Right

func _on_transition_completed() -> void:
	Globals.Samus.hide_black_screen()
	_lock()


func _unlock(door: Node2D) -> void:
	collision_mask -= Globals.bit_masks["samus"]
	door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", true)
	# Animate instead of hide
	door.get_node("Sprites/Door").hide()


func _lock() -> void:
	collision_mask += Globals.bit_masks["samus"]
	# set timer and close the door instead
	left_door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", false)
	right_door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", false)
	left_door.get_node("Sprites/Door").show()
	right_door.get_node("Sprites/Door").show()


func _on_Left_Lock_area_entered(area: Area2D) -> void:
	_unlock(left_door)


func _on_Right_Lock_area_entered(area: Area2D) -> void:
	_unlock(right_door)


func _on_Left_Transition_body_entered(samus: Samus) -> void:
	var camera := _setup_camera_transition(samus)
	camera.transition(get_node(left_room_path), get_node(right_room_path), self)


func _on_Right_Transition_body_entered(samus: Samus) -> void:
	var camera := _setup_camera_transition(samus)
	camera.transition(get_node(right_room_path), get_node(left_room_path), self, false)


func _setup_camera_transition(samus: Samus) -> MainCamera:
	var camera: MainCamera = samus.get_node("Camera2D")
	camera.connect("transition_completed", self, "_on_transition_completed")
	samus.show_black_screen()
	return camera
