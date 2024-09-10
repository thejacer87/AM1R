class_name Missile
extends Area2D

@export var direction: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	Globals.SFXPlayer.play(Globals.SFXPlayer.sfx.missile as String)


func _physics_process(delta: float) -> void:
	position.x += 300 * delta * direction.x
	position.y += 300 * delta * direction.y


func _on_area_entered(area: Area2D) -> void:
	print("colliding")
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("colliding body")
	queue_free()
	pass # Replace with function body.


func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
