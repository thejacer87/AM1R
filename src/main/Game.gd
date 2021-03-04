extends Node

var _path := "user://savegame.save"
var _data := { }

onready var game_viewport := $GameViewportContainer/Viewport


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
		_data = _load_new_game_data()

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("PERSIST")
	for i in save_nodes:
		i.queue_free()

	save_game.open("user://savegame.save", File.READ)

	var text = save_game.get_as_text()

	if text.empty():
		_data = _load_new_game_data()
	else:
		_data = parse_json(text)


	var gameplay_ui = preload("res://src/interface/GameplayUI.tscn").instance()
	Globals.UI.add_child(gameplay_ui)
	# Gameplay UI has been added to the tree now, so check if there is map data,
	# and reaplace it if so.
	var map_data = _data.Map
	if not map_data.empty():
		var map = gameplay_ui.get_node("MapContainer/Viewport/Map")
		var areas = map.get_node("Areas")
		for area in areas.get_children():
			if map_data[area.call("save_name")]:
				# Remove all the tilemaps and add the saved tilemaps back in.
				# Cannot just delete the map and instance that because the signals
				# will not be connected.
				var saved_map = load(map_data[area.call("save_name")].filename).instance()
				var old_tilemaps = area.get_children()
				for tile_map in saved_map.get_children():
					saved_map.remove_child(tile_map)
					area.add_child(tile_map, true)
				for tile_map in old_tilemaps:
					tile_map.free()
				area.recalibrate()


	var samus_data = _data.Samus
	var samus = load(samus_data.properties.filename).instance()
	var area = load(samus_data.current_area.filename).instance()

	game_viewport.add_child(area)
	area.add_child(samus)
	# Put Samus behind the Doors
	area.move_child(samus, area.get_child_count() - 2)
	samus.position = Vector2(samus_data.properties.pos_x, samus_data.properties.pos_y)

	# Now we set the remaining variables.
	for i in samus_data.properties.keys():
		if i == "filename":
			continue
		samus.set(i, samus_data.properties[i])

	samus.bind_camera_limits()
	save_game.close()


func _load_new_game_data() -> Dictionary:
	var new_game = File.new()
	new_game.open("res://src/main/newgame.save", File.READ)
	var data = new_game.get_as_text()
	return parse_json(data)
