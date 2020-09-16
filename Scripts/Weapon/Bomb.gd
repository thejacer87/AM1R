extends Area2D

signal bomb_jump()

export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
onready var explosion := $ExplosionHitbox
onready var bomb_jump := $BombJumpHitbox
onready var animation_player := $AnimationPlayer


func _ready() -> void:
	rotation_degrees = rad2deg(direction.angle())


func _on_Timer_timeout():
	explosion.set_deferred("monitoring", true)
	explosion.set_deferred("monitorable", true)
	bomb_jump.set_deferred("monitoring", true)
	bomb_jump.set_deferred("monitorable", true)
	animation_player.play("Detonate")


func _on_ExplosionHitbox_area_entered(area):
	print('bomed an area')


func _on_BombJumpHitbox_body_entered(samus):
	samus.bomb_jump()

