extends Node2D

onready var tilemap := $TileMaps/DynamicTileMap

var weak_block := preload("res://Scenes/Levels/WeakBlock.tscn")

func _ready() -> void:
	_convert_tilecells_to_nodes()

func _convert_tilecells_to_nodes() -> void:
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

			if child != null:
				child.position = tilemap.map_to_world(cell) + (tilemap.cell_size / 2) + offset
				add_child(child)
	tilemap.clear()
