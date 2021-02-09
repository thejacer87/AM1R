extends Area2D

export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
onready var explosion := $ExplosionHitbox
onready var bomb_jump := $BombJumpHitbox
onready var animation_player := $AnimationPlayer


func _ready() -> void:
	Globals.GameSFX.play("res://assets/audio/sfx/bomb_drop.wav")


func _on_Timer_timeout():
	animation_player.play("Detonate")
	Globals.GameSFX.play("res://assets/audio/sfx/bomb_explode.wav")


func _on_BombJumpHitbox_body_entered(samus: Samus):
	samus.bomb_jump()
