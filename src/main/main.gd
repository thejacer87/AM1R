class_name Main
extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"


@onready var hud: HUD = %HUD
@onready var map_menu: Control = %MapMenu


@export_file("*.tscn") var starting_area_path: String
var _save: SaveGame


func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Initialize room when it changes.
	room_loaded.connect(init_room, CONNECT_DEFERRED)
	
	# Get starting area.
	var mrf := MetSys.settings.map_root_folder
	# Get just the name of the scene relative to the MetSys map root folder as it expects.
	var room_path := starting_area_path.replace(mrf if mrf.ends_with("/")  else mrf + "/", "")
	load_room(room_path)
	
	Globals.MusicPlayer.play("res://src/audio/music/musArea2A.ogg")
	create_or_load_save()
	load_players()
	
	# Add module for room transitions.
	#add_module("RoomTransitions.gd");
	add_custom_module("ScrollingRoomTransitions.gd")


func _process(delta: float) -> void:
	pass


func create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_save_game() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_save_game()
		
		
func load_players() -> void:
	# Find all players for initialization.
	for index in Input.get_connected_joypads():
		var player: Samus = preload("res://src/entities/characters/samus/samus.tscn").instantiate() as Samus
		player.position = Vector2(1388, 130)
		player.player_index = index
		add_child(player)
		player.connect_hud(hud)
		player.collectibles = _save.collectibles
		if index == 0:
			set_player(player)


func init_room() -> void:
	var room := MetSys.get_current_room_instance().get_parent() as Room
	(player as Samus).bind_camera_limits(room)
