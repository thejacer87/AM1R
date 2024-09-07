class_name Pickup
extends Area2D

signal collected_pickup(pickup_name: String)

@export var pickup_name: String

func _on_body_entered(body: Node2D) -> void:
	print("Collected: " + str(name))
	var samus: Samus = body as Samus
	self.collected_pickup.connect(samus._on_collected_pickup)
	collected_pickup.emit(pickup_name)
	queue_free()
