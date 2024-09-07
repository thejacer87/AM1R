extends Node2D

@onready var energy_scene := preload("res://src/entities/items/pickups/energy_tank.tscn")
@onready var missile_scene := preload("res://src/entities/items/pickups/missile_rocket.tscn")


func _ready() -> void:
	randomize()
	var roll := randi() % 10
	if roll > 5:
		_drop_energy()
	elif roll == 9:
		_drop_energy(false)
	else:
		_drop_missile()


func _drop_energy(small: bool = true) -> void:
	print("drop energy")
	#var energy := energy_scene.instantiate() as Ener
	#get_tree().get_root().add_child(energy)
	#energy.small = small
	#if not small:
		#energy.scale = Vector2(1.5, 1.5)
	#energy.global_position = global_position
	#queue_free()


func _drop_missile() -> void:
	print("drop missile")
	# todo make proper drops
	var missile := missile_scene.instantiate() as Pickup
	get_tree().get_root().add_child(missile)
	missile.global_position = global_position
	queue_free()
