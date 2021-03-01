extends CanvasLayer

var mini_map_scene := preload("res://src/map/Map.tscn")

onready var mini_map_view := $MiniMap/Viewport


func _ready() -> void:
	Globals.UI = self
	mini_map_view.add_child(Globals.GameMap.duplicate())
