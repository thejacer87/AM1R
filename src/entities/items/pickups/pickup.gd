class_name Pickup
extends Area2D


signal collected_pickup(pickup: Pickup)


@export var pickup_name: String


func _on_body_entered(body: Node2D) -> void:
	print("Collected: " + str(name))
	var samus: Samus = body as Samus
	self.collected_pickup.connect(samus._on_collected_pickup)
	collected_pickup.emit(self)
	queue_free()


func _on_timer_timeout() -> void:
	#todo add a fading animation first? 
	queue_free()
