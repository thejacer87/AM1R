class_name EnemyFactory
extends Node2D

export(PackedScene) var enemy

var _enemy: Enemy

onready var _spawned_enemies := $SpawnedEnemies
onready var _spawn_point := $SpawnPoint


func _ready() -> void:
	_enemy = enemy.instance()
	_enemy.position = _spawn_point.position
	_enemy.starting_pos = _spawn_point.position
	add_child(_enemy)
	move_child(_enemy, 0)


func _physics_process(delta: float) -> void:
	var has_pickups = false
	for child in get_children():
		if child.is_in_group("pickup"):
			has_pickups = true

	if _enemy.is_dead and not has_pickups:
		_respawn_enemy()


func _respawn_enemy() -> void:
	_enemy.position = _spawn_point.position
	_enemy.die(false)
	_enemy.regenerate()
