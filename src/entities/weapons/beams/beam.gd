class_name Beam
extends Area2D

@export var direction := Vector2.RIGHT

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	if direction == Vector2.LEFT:
		sprite_2d.flip_h = true


func _physics_process(delta: float) -> void:
	position.x += 250 * delta * direction.x
