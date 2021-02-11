extends Node2D

export(NodePath) var entry

var weak_block := preload("res://src/areas/WeakBlock.tscn")
var zoomer := preload("res://src/enemies/zoomer/Zoomer.tscn")
var skree := preload("res://src/enemies/skree/Skree.tscn")
var ripper := preload("res://src/enemies/ripper/Ripper.tscn")
var waver := preload("res://src/enemies/waver/Waver.tscn")

onready var rooms := $Rooms
onready var doors := $Doors
onready var entry_elevator := $Rooms/K/Elevator


func _ready() -> void:
	for room in rooms.get_children():
		var tilemap = room.get_node("TileMaps/DynamicTileMap")
		_convert_tilecells_to_nodes(tilemap)

	# Move Doors to front of tree so Samus will be rendered underneath.
	move_child(doors, get_child_count())
	Globals.GameMusic.play("res://assets/audio/music/brinstar.wav")


func _on_transition_out_finished() -> void:
	if entry_elevator:
		var animation_player = entry_elevator.get_animation_player()
		AreaTransition.transition_in(animation_player, "up", entry)
		AreaTransition.disconnect("transition_out_finished", self, "_on_transition_out_finished")
		yield(animation_player, "animation_finished")


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
				"skree":
					offset = Vector2(0, 8)
					child = skree.instance()
				"ripper":
					offset = Vector2(0, 8)
					child = ripper.instance()
				"waver":
#					offset = Vector2(0, 8)
					child = waver.instance()

			if child != null:
				child.position = tilemap.map_to_world(cell) + (tilemap.cell_size / 2) + offset
				tilemap.get_parent().add_child(child)
	tilemap.clear()
