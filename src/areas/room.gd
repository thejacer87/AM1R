class_name Room
extends Node2D


@export var grid_size := Vector2.ONE
@export var pickups : Array[RoomCollectible] = []
@export var room_offset := 0
@export var power_items : Array[RoomCollectible] = []
@export var doors : Array[Door] = []:
	get:
		var carry: Array[Door] = []
		for child in self.find_children("*"):
			if child.is_in_group("door"):
				carry.append(child)
		return carry

@onready var camera_bounds :=  {
			"top": $CameraBounds/Top,
			"bottom": $CameraBounds/Bottom,
			"left": $CameraBounds/Left,
			"right": $CameraBounds/Right
		}


func _ready() -> void:
	EventBus.connect("room_transition_finished", enable_exits)
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


func enable_exits(player: Samus, room: Room) -> void:
	if room == self:
		print("enable Exits for ", get_path())
		for door in doors:
			door.enable_collisions()
		get_tree().paused = false
		player.collision_layer = Globals.COLLISION_PLAYER
