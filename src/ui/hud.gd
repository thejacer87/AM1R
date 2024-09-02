class_name HUD
extends Control

@export var player: Samus

@onready var energy_label: Label = $HBoxContainer/EnergyLabel
@onready var missiles: Control = $HBoxContainer/Missiles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	energy_label.text = str(player.energy)
