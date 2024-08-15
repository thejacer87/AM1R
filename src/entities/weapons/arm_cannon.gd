class_name ArmCannon
extends Node2D

@onready var projectile_marker: Marker2D = $ProjectileMarker
@onready var beam := preload("res://src/entities/weapons/beams/beam.tscn")
@onready var flash_sprite_2d: Sprite2D = $FlashSprite2D
@onready var flash_animation_player: AnimationPlayer = $FlashSprite2D/FlashAnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot() -> void:
	var bullet := beam.instantiate() as Beam
	bullet.direction = (Vector2.RIGHT * scale).rotated(rotation).normalized()
	bullet.position = global_position
	bullet.rotation = rotation
	bullet.scale = scale
#	This makes the flash not rotate.
	flash_sprite_2d.rotation = -rotation
	flash_animation_player.play("flash")
	get_tree().get_root().add_child(bullet)
