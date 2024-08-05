extends Node2D

@onready var samus: Samus = $Samus
@onready var label: Label = $Label
@onready var input_label: Label = $InputLabel


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for index in Input.get_connected_joypads():
		input_label.text += "Player " + str(index + 1) + ": " + str(Input.get_joy_name(index)) + "\n"


func _process(delta: float) -> void:
	label.text = "Energy: " + str(samus.energy)
	pass
	
