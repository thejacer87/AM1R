class_name ArmCannon
extends Node2D

@onready var projectile_marker: Marker2D = $ProjectileMarker
@onready var beam := preload("res://src/entities/weapons/beams/beam.tscn")
@onready var missile := preload("res://src/entities/weapons/missiles/missile.tscn")
@onready var flash_sprite_2d: Sprite2D = $FlashSprite2D
@onready var flash_animation_player: AnimationPlayer = $FlashSprite2D/FlashAnimationPlayer


var samus: Samus

func _ready() -> void:
	await owner.ready
	samus = owner as Samus
	assert(samus != null, "The MovementState state type must be used only in the samus scene. It needs the owner to be a Samus node.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot() -> void:
	if samus.is_missile_armed:
		var shot := missile.instantiate() as Missile
		shot.direction = (Vector2.RIGHT * scale).rotated(rotation).normalized()
		shot.position = global_position
		shot.rotation = rotation
		shot.scale = scale
		get_tree().get_root().add_child(shot)
	else:
		var beam := beam.instantiate() as Beam
	#	This makes the flash not rotate.
		flash_sprite_2d.rotation = -rotation
		flash_animation_player.play("flash")
		beam.direction = (Vector2.RIGHT * scale).rotated(rotation).normalized()
		beam.position = global_position
		beam.rotation = rotation
		beam.scale = scale
		get_tree().get_root().add_child(beam)
