class_name Enemy
extends CharacterBody2D

@export var starting_hp := 10

var hp: int
var starting_pos: Vector2
var is_dead := false

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_spawner := preload("res://src/entities/items/pickups/pickup_spawner.tscn")


func _ready() -> void:
	hp = starting_hp
	starting_pos = position


func _physics_process(delta: float) -> void:
	_move(delta)
	if (hp <= 0):
		_die()


func _move(delta: float) -> void:
	pass


func _regenerate() -> void:
	hp = starting_hp
	is_dead = false
	_enable_collisions()
	_show_sprite()
	set_physics_process(true)


func damage(amount: int) -> void:
	hp -= amount


func _die(drop_item := true) -> void:
	if drop_item:
		drop_item()
	set_physics_process(false)
	_disable_collisions()
	_hide_sprite()
	is_dead = true
	position = starting_pos


func drop_item() -> void:
	add_child(pickup_spawner.instantiate())


func _disable_collisions() -> void:
	hitbox.monitorable = false
	hitbox.monitoring = false
	hurtbox.monitorable = false
	hurtbox.monitoring = false
	collision_shape_2d.disabled = true


func _enable_collisions() -> void:
	hitbox.monitorable = true
	hitbox.monitoring = true
	hurtbox.monitorable = true
	hurtbox.monitoring = true
	collision_shape_2d.disabled = false


func _hide_sprite() -> void:
	animated_sprite_2d.visible = false


func _show_sprite() -> void:
	animated_sprite_2d.visible = true
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		var hitbox := area as Hitbox
		damage(hitbox.damage)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	if is_dead:
		_regenerate()
