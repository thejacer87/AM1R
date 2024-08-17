class_name Missile
extends Area2D

@export var direction: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.play()


func _physics_process(delta: float) -> void:
	position.x += 500 * delta * direction.x
	position.y += 500 * delta * direction.y


func _on_area_entered(area: Area2D) -> void:
	print("colliding")
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("colliding body")
	queue_free()
	pass # Replace with function body.
