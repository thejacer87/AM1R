class_name Pickup
extends Area2D


func _ready():
	pass


func _on_PickUp_body_entered(samus: Samus) -> void:
	print(samus.name)
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
