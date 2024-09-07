extends Node2D


@onready var samus: Samus = $Samus
@onready var samus_2: Samus = $Samus2
@onready var samus_3: Samus = $Samus3
@onready var samus_4: Samus = $Samus4
@onready var input_label: Label = $InputLabel
@onready var hud: HUD = %HUD
@onready var b1: Room = $"B-1"


var _save: SaveGame


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	create_or_load_save()
	for index in Input.get_connected_joypads():
		input_label.text += "Player " + str(index + 1) + ": " + str(Input.get_joy_name(index)) + "\n"


func _process(delta: float) -> void:
	pass


func create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_save_game() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_save_game()
	
	for player: Samus in [samus, samus_2, samus_3, samus_4]:
		player.connect_hud(hud)
		player.collectibles = _save.collectibles

	samus.bind_camera_limits(b1)

	for exit: RoomExit in b1.exits:
		exit.enable_collisions()
