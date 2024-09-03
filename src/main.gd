extends Node2D


@onready var samus: Samus = $Samus
@onready var samus_2: Samus = $Samus2
@onready var input_label: Label = $InputLabel
@onready var hud: HUD = %HUD


var _save: SaveGame


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	samus.etanks_updated.connect(hud._on_energy_tanks_updated)
	samus.energy_updated.connect(hud._on_energy_updated)
	samus.missile_count_updated.connect(hud._on_missile_count_updated)
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
		
	samus.collectibles = _save.collectibles
	#samus_2.collectibles = _save.collectibles
