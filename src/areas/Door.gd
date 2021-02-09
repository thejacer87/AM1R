extends StaticBody2D

signal transition_started

const COLLISION_MASK_LOCKED := 9
const COLLISION_MASK_UNLOCKED := 8

export (NodePath) var left_room_path
export (NodePath) var right_room_path

onready var wall := $Wall
onready var left_door := $Left
onready var right_door := $Right


func _unlock(door: Node2D) -> void:
	collision_mask = COLLISION_MASK_UNLOCKED
	door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", true)
	# Animate instead of hide
	door.get_node("Sprites/Door").hide()


func _lock() -> void:
	collision_mask = COLLISION_MASK_LOCKED
	# set timer and close the door instead
	left_door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", false)
	right_door.get_node("ClosedDoor/CollisionShape2D").set_deferred("disabled", false)
	left_door.get_node("Sprites/Door").show()
	right_door.get_node("Sprites/Door").show()


func _on_transition_completed() -> void:
	_lock()


func _on_Left_Lock_area_entered(area: Area2D) -> void:
	_unlock(left_door)


func _on_Right_Lock_area_entered(area: Area2D) -> void:
	_unlock(right_door)


func _on_Left_Transition_body_entered(samus: Samus) -> void:
	connect("transition_started", samus, "_on_transition_started")
	emit_signal("transition_started", get_node(left_room_path), get_node(right_room_path), self, true)


func _on_Right_Transition_body_entered(samus: Samus) -> void:
	connect("transition_started", samus, "_on_transition_started")
	emit_signal("transition_started", get_node(right_room_path), get_node(left_room_path), self, false)
