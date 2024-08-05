extends Node2D

@onready var samus: Samus = $Samus
@onready var label: Label = $Label
@onready var input_label: Label = $InputLabel


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	input_label.text = "Input: " + str(Input.get_joy_name(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Energy: " + str(samus.energy)
	pass
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		samus.damage(3)
