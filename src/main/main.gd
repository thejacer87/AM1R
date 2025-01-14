class_name Main
extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"

@onready var hud: HUD = %HUD

# The game starts in this map. Note that it's scene name only, just like MetSys refers to rooms.
@export var starting_area: String
var _save: SaveGame


func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Initialize room when it changes.
	room_loaded.connect(init_room, CONNECT_DEFERRED)
	load_room(starting_area)
	
	Globals.MusicPlayer.play("res://src/audio/music/musArea2A.ogg")
	create_or_load_save()
	
	# Add module for room transitions.
	add_module("RoomTransitions.gd")


func _process(delta: float) -> void:
	pass


func create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_save_game() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_save_game()
		
	# Find all players for initialization.
	for index in Input.get_connected_joypads():
		var player: Samus = preload("res://src/entities/characters/samus/samus.tscn").instantiate() as Samus
		player.position = Vector2(388, 130)
		player.player_index = index
		add_child(player)
		player.connect_hud(hud)
		player.collectibles = _save.collectibles
		if index == 0:
			set_player(player)

func init_room() -> void:
	var room := MetSys.get_current_room_instance().get_parent() as Room
	(player as Samus).bind_camera_limits(room)
