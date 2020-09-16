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
	# play explosion animation
#	explosion_shape.set_deferred("disabled", false)
	explosion.set_deferred("monitored", true)
	explosion.set_deferred("monitorable", true)
	bomb_jump.set_deferred("monitored", true)
	bomb_jump.set_deferred("monitorable", true)
	animation_player.play("Detonate")
	print('exploded')
	yield(get_tree().create_timer(2), "timeout")
	print('see ya')
	queue_free()


func _on_ExplosionHitbox_area_entered(area):
	print('bombed ' + area.name)


func _on_BombJumpHitbox_body_entered(samus):
	print('bomb jump')
	emit_signal("bomb_jump")
