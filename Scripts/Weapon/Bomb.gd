extends Area2D

export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
onready var explosion := $ExplosionHitbox
onready var bomb_jump := $BombJumpHitbox
onready var animation_player := $AnimationPlayer


func _on_Timer_timeout():
	animation_player.play("Detonate")


func _on_BombJumpHitbox_body_entered(samus):
	samus.bomb_jump()
