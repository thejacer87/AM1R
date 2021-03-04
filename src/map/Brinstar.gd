extends Control

enum Colours { BLUE = 1, GREY = 2 }
enum Items {  HIDDEN, COLLECTED }

const ROOM_SIZE := 8

onready var colour := $Colour
onready var items := $Items
onready var walls := $Walls
onready var doors := $Doors


func _ready() -> void:
	pass


func _on_visited_room(room) -> void:
	room /= 8
	if colour:
		colour.set_cellv(room, Colours.BLUE)


func _on_item_collected(room) -> void:
	var pos = room / 32
	pos.x = ROOM_SIZE * floor(abs(pos.x / ROOM_SIZE))
	pos.y = ROOM_SIZE * floor(abs(pos.y / ROOM_SIZE))
	if items:
		items.set_cellv(pos / 8, Items.COLLECTED)


func recalibrate() -> void:
	colour = find_node("Colour*", true, false)
	items = find_node("Items*", true, false)
	walls = find_node("Walls*", true, false)
	doors = find_node("Doors*", true, false)
	colour.set_owner(self)
	items.set_owner(self)
	walls.set_owner(self)
	doors.set_owner(self)


func save_name() -> String:
	return "Brinstar"


func save() -> Dictionary:
	var packed_scene = PackedScene.new()
	packed_scene.pack(self)
	#var filename = "res://src/brin.tscn" for debug, easier to find/open in
	# godot fileSystem if its in src
	# for subdir, will need to check and create first. see:
	# https://godotengine.org/qa/1288/error-on-create-directory-on-exported-game?show=3096#a3096
	var filename = "user://map_brinstar.tscn"
	if ResourceSaver.save(filename, packed_scene) == OK:
		return {"filename": filename}
	else:
		return {}
