extends CanvasLayer

var mini_map_scene := preload("res://src/map/Map.tscn")

onready var mini_map_view := $MiniMap/Viewport


func _ready() -> void:
	Globals.UI = self
	var mini_map = mini_map_scene.instance()
	mini_map.mini = true
	mini_map._zoomed = false
	mini_map_view.add_child(mini_map)
