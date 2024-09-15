extends Node2D


@onready var energy_capsule_scene := preload("res://src/entities/items/pickups/energy_capsule/energy_capsule.tscn")
@onready var missile_ammo_scene := preload("res://src/entities/items/pickups/missile_ammo/missile_ammo.tscn")


func _ready() -> void:
	randomize()
	var roll := randi() % 10
	if roll < 5:
		_drop_energy()
	elif roll == 5:
		_drop_energy(EnergyCapsule.EnergySize.MEDIUM)
	else:
		_drop_missile()


func _drop_energy(size: int = EnergyCapsule.EnergySize.SMALL) -> void:
	var energy := energy_capsule_scene.instantiate() as EnergyCapsule
	energy.size = size
	get_tree().get_root().add_child(energy)
	energy.global_position = global_position
	queue_free()


func _drop_missile() -> void:
	var missile := missile_ammo_scene.instantiate() as Pickup
	get_tree().get_root().add_child(missile)
	missile.global_position = global_position
	queue_free()
