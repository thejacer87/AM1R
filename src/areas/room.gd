class_name Room
extends Node2D


@export var grid_size := Vector2.ONE
@export var pickups : Array[RoomCollectible] = []
@export var power_items : Array[RoomCollectible] = []
@export var exits : Array[RoomExit] = []:
	get:
		var carry: Array[RoomExit] = []
		for child in self.find_children("*"):
			if child.is_in_group("room_exit"):
				carry.append(child)
		return carry


@onready var camera_bounds: Node2D = $CameraBounds


func _ready() -> void:
	for pickup in pickups:
		var scene := pickup.item_scene
		var item := scene.instantiate() as Pickup
		item.position = pickup.position
		add_child(item)
	for power_item in power_items:
		var scene := power_item.item_scene
		var item := scene.instantiate() as PowerItem
		item.position = power_item.position
		add_child(item)
