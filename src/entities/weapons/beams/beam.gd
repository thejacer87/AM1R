class_name Beam
extends Area2D

@export var direction: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flash_sprite_2d: Sprite2D = $FlashSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.play()


func _physics_process(delta: float) -> void:
	position.x += 400 * delta * direction.x
	position.y += 400 * delta * direction.y
