class_name Enemy
extends KinematicBody2D

enum DirectionsX {LEFT = -1, RIGHT = 1}
enum DirectionsY {UP = -1, DOWN = 1}

export var starting_hp = 10

var hp: int
var starting_pos: Vector2
var is_dead := false

onready var hitbox := $Hitbox
onready var hurtbox := $Hurtbox
onready var item_dropper_scene := preload("res://src/pickups/ItemDropper.tscn")


func _ready() -> void:
	hp = starting_hp
	starting_pos = position


func _physics_process(delta: float) -> void:
	_move(delta)
	if (hp <= 0):
		die()


func regenerate() -> void:
	hp = starting_hp
	is_dead = false
	_enable_collisions()
	show()
	set_physics_process(true)


func die(drop_item := true) -> void:
	if drop_item:
		_drop_item()
	set_physics_process(false)
	_disable_collisions()
	hide()
	is_dead = true
	position = starting_pos


func _move(delta: float) -> void:
	pass


func _damage(amount: int) -> void:
	hp -= amount


func _drop_item() -> void:
	add_child(item_dropper_scene.instance())
	emit_signal("pickup_dropped")


func _disable_collisions() -> void:
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	hurtbox.set_deferred("monitoring", false)
	hurtbox.set_deferred("monitorable", false)


func _enable_collisions() -> void:
	hitbox.set_deferred("monitoring", true)
	hitbox.set_deferred("monitorable", true)
	hurtbox.set_deferred("monitoring", true)
	hurtbox.set_deferred("monitorable", true)


func _on_Hurtbox_area_entered(area: Area2D):
	if area is Hitbox:
		_damage(area.damage)


func _on_VisibilityEnabler2D_screen_exited() -> void:
	if is_dead:
		regenerate()
