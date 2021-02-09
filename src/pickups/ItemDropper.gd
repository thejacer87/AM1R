extends Node2D

onready var energy_scene = preload("res://src/pickups/Energy.tscn")
onready var missile_scene = preload("res://src/pickups/Missile.tscn")


func _ready() -> void:
	randomize()
	var roll = randi() % 10
	if roll > 5:
		_drop_energy()
	elif roll == 9:
		_drop_energy(false)
	else:
		_drop_missile()


func _drop_energy(small: bool = true) -> void:
	var energy = energy_scene.instance()
	get_tree().get_root().add_child(energy)
	energy.small = small
	if not small:
		energy.scale = Vector2(1.5, 1.5)
	energy.global_position = global_position
	queue_free()


func _drop_missile() -> void:
	var missile = missile_scene.instance()
	get_tree().get_root().add_child(missile)
	missile.global_position = global_position
	queue_free()
