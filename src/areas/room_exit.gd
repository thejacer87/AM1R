class_name RoomExit
extends Area2D

@export var next_room: Room

@onready var current_room: Room = get_parent()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	disable_collisions()


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var player := body as Samus
	for exit: RoomExit in current_room.exits:
		exit.disable_collisions()
	for exit: RoomExit in next_room.exits:
		exit.enable_collisions()
	
	player.bind_camera_limits(next_room)


func enable_collisions() -> void:
	set_collision_mask_value(1, true)


func disable_collisions() -> void:
	set_collision_mask_value(1, false)
