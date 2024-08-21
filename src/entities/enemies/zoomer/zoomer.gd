class_name Zoomer
extends Enemy
@onready var label: Label = $Label


func _process(delta: float) -> void:
	label.text = "HP: " + str(hp)

func _move(delta: float) -> void:
	pass # Replace with function body.
