extends Control

enum Colours { BLUE = 1, GREY = 2 }
enum Items {  HIDDEN, COLLECTED }

const ROOM_SIZE := 8

onready var colour := $Colour
onready var items := $Items
onready var walls := $Walls


func _ready() -> void:
	pass


func _on_visited_room(room) -> void:
	room /= 8
	colour.set_cellv(room, Colours.BLUE)


func _on_item_collected(room) -> void:
	var pos = room / 32
	pos.x = ROOM_SIZE * floor(abs(pos.x / ROOM_SIZE))
	pos.y = ROOM_SIZE * floor(abs(pos.y / ROOM_SIZE))
	items.set_cellv(pos / 8, Items.COLLECTED)
