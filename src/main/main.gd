extends Node2D


@onready var input_label: Label = %InputLabel
@onready var hud: HUD = %HUD
@onready var b1: Room = $"B-1"


var _save: SaveGame


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	create_or_load_save()
	for index in Input.get_connected_joypads():
		input_label.text += "Player " + str(index + 1) + ": " + str(Input.get_joy_name(index)) + "\n"
	
	Globals.MusicPlayer.play("res://src/audio/music/musArea2A.ogg")


func _process(delta: float) -> void:
	pass


func create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_save_game() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_save_game()
	
	# Find all players for initialization.
	for player: Samus in self.find_children("*", "Samus", false):
		player.connect_hud(hud)
		player.collectibles = _save.collectibles
		if player.player_index == 0:
			player.bind_camera_limits(b1)

	for door: Door in b1.doors:
		door.enable_collisions()
