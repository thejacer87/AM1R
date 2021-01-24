class_name Zoomer
extends KinematicBody2D

const HP := 20

export var direction := 1

var rotating: int
var starting_pos : Vector2
var move := Vector2.ZERO
var speed := 43
var is_dead := false

onready var collision_shape : CircleShape2D = $CollisionShape2D.shape
onready var hp := HP

func _ready() -> void:
	starting_pos = position


func _physics_process(delta: float) -> void:
	_walk_on_walls(delta)
	if (hp <= 0):
		_die()


func _regenerate() -> void:
	hp = HP
	is_dead = false
	show()
	set_physics_process(true)


func _die() -> void:
	set_physics_process(false)
	hide()
	is_dead = true
	position = starting_pos


func _damage(amount: int) -> void:
	hp -= amount


func _walk_on_walls(delta: float) -> void:
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return

	var col := move_and_collide(move * speed * delta * direction)
	if col and col.normal.rotated(PI / 2).dot(move) < 0.5:
		rotating = 4
		move = col.normal.rotated(PI / 2)
		return

	var pos := position
	var multiplier = collision_shape.radius / 2
	col = move_and_collide(move.rotated(PI / 2) * multiplier)
	if not col:
		for i in 10:
			position = pos
			rotate(PI / 32)
			move = move.rotated(PI / 32)
			col = move_and_collide(move.rotated(PI / 2) * multiplier)

			if col:
				move = col.normal.rotated(PI / 2)
				rotation = move.angle()
				break
	else:
		move = col.normal.rotated(PI / 2)
		rotation = move.angle()


func _on_Hurtbox_area_entered(hitbox: Hitbox):
	_damage(hitbox.damage)


func _on_VisibilityEnabler2D_screen_exited() -> void:
	if is_dead:
		_regenerate()
