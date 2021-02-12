extends Node

var _path := "user://savegame.save"
var _data := { }
var _new_game := {
	"samus": {
		"filename": "res://src/samus/Samus.tscn",
		"missile_count": 0,
		"collected_powerups": [],
		"current_room_path": "../Rooms/A",
		"pos_x": 480,
		"pos_y": 176,
	},
	"area": {
		"filename": "res://src/areas/brinstar/Brinstar.tscn",
	},
}


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	_load_game()


func restart() -> void:
	for child in get_children():
		child.queue_free()
	_load_game()


func _load_game() -> void:
	var save_game = File.new()

	# Will need to pass in save slot when time comes.
	if not save_game.file_exists(_path):
		_data = _new_game

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		i.queue_free()

	save_game.open("user://savegame.save", File.READ)

	var text = save_game.get_as_text()

	if text.empty():
		_data = _new_game
	else:
		_data = parse_json(text)

	var samus = load(_data.samus.filename).instance()
	var area = load(_data.area.filename).instance()
	add_child(area)
	area.add_child(samus)
	# Put Samus behind the Doors
	area.move_child(samus, area.get_child_count() - 2)
	samus.position = Vector2(_data.samus.pos_x, _data.samus.pos_y)

	# Now we set the remaining variables.
	for i in _data.samus.keys():
		if i == "filename":
			continue
		samus.set(i, _data.samus[i])

	samus.bind_camera_limits()
	save_game.close()

