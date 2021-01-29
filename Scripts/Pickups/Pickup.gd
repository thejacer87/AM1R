extends Area2D

class_name Pickup

func _ready():
	pass


func _on_PickUp_body_entered(samus: Samus) -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
