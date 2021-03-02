extends ViewportContainer

onready var viewport := $Viewport
onready var map := $Viewport/Map


func show_map() -> void:
	_set_full_map_sizes()
	map.show_map()


func hide_map() -> void:
	_set_mini_map_sizes()
	map.hide_map()


func _set_full_map_sizes() -> void:
	rect_size = Vector2(Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT)
	rect_position = Vector2.ZERO
	anchor_top = 0
	anchor_left = 0
	anchor_right = 1
	anchor_bottom = 1
	margin_left = 0
	margin_top = 0
	margin_right = 0
	margin_bottom = 0
	viewport.size = Vector2(Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT)


func _set_mini_map_sizes() -> void:
	rect_size = Vector2(64, 24)
	rect_position = Vector2(444, 4)
	anchor_top = 0
	anchor_left = 1
	anchor_right = 1
	anchor_bottom = 0
	margin_left = -68
	margin_top = 4
	margin_right = -4
	margin_bottom = 28
	viewport.size = Vector2(64, 24)
