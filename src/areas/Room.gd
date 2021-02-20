class_name Room
extends Node2D

onready var camera_bounds := $CameraBounds
onready var tilemap := $TileMaps/TileMap
onready var dynamic_tilemap := $TileMaps/DynamicTileMap

func _ready() -> void:
	deactivate()
	pass

func activate() -> void:
	show()
	tilemap.collision_layer = 4
	dynamic_tilemap.collision_layer = 4
	set_physics_process(false)
	set_process(false)
	pass

func deactivate() -> void:
	hide()
	tilemap.collision_layer = 0
	dynamic_tilemap.collision_layer = 0
	set_physics_process(false)
	set_process(false)
	pass
