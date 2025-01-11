class_name Main
extends Node2D
#extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"

@onready var hud: HUD = %HUD
@onready var brinstar := preload("res://src/areas/brinstar/brinstar.tscn").instantiate()


var _save: SaveGame


func _ready() -> void:
	#MetSys.reset_state()
	#MetSys.set_save_data()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# load and add all areas
	add_child(brinstar)
	
	Globals.MusicPlayer.play("res://src/audio/music/musArea2A.ogg")
	create_or_load_save()


func _process(delta: float) -> void:
	pass


func create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_save_game() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_save_game()
		
	var room : Room
	for child in brinstar.get_children():
		if child.is_in_group("room"):
			room = child
			break
	# Find all players for initialization.
	for index in Input.get_connected_joypads():
		var player: Samus = preload("res://src/entities/characters/samus/samus.tscn").instantiate() as Samus
		player.position = Vector2(128, 130)
		player.player_index = index
		add_child(player)
		player.connect_hud(hud)
		player.collectibles = _save.collectibles
		if index == 0:
			#set_player(player)
			player.bind_camera_limits(room)
