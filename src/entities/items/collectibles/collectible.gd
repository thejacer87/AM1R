class_name Collectible
extends Area2D


signal collected_collectible(pickup: Collectible)


@export var collectible_name: String


func _on_body_entered(body: Node2D) -> void:
	var samus: Samus = body as Samus
	self.collected_collectible.connect(samus._on_collected_collectible)
	collected_collectible.emit(self)
	queue_free()
