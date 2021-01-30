extends Node2D

var weak_block := preload("res://Scenes/Levels/WeakBlock.tscn")
var zoomer := preload("res://Scenes/Enemies/Zoomer.tscn")

onready var rooms := $Rooms
onready var doors := $Doors


func _ready() -> void:
	for room in rooms.get_children():
		var tilemap = room.get_node("TileMaps/DynamicTileMap")
		_convert_tilecells_to_nodes(tilemap)

	# Move Doors to front of tree so Samus will be rendered underneath.
	move_child(doors, get_child_count())


func _convert_tilecells_to_nodes(tilemap) -> void:
	var cells = tilemap.get_used_cells()
	for cell in cells:
		var cell_id = tilemap.get_cellv(cell)
		if cell_id != tilemap.INVALID_CELL:
			var tile_name = tilemap.tile_set.tile_get_name(cell_id)
			var child
			var offset = Vector2.ZERO
			match tile_name:
				"weak_block":
					child = weak_block.instance()
				"zoomer":
					child = zoomer.instance()

			if child != null:
				child.position = tilemap.map_to_world(cell) + (tilemap.cell_size / 2) + offset
				add_child(child)
	tilemap.clear()
