extends Node2D

@onready var samus: Samus = $Samus
@onready var label: Label = $Label


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Energy: " + str(samus.energy)
	pass
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		samus.damage(3)
