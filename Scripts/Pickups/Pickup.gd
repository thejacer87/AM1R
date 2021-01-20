extends Area2D

class_name Pickup

func _ready():
	pass


func _on_Pickup_body_entered(body):
	print("pickup grabbed")
