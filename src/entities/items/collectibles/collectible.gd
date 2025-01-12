class_name Collectible
extends Area2D


signal collected_collectible(pickup: Collectible)


@export var collectible_name: String


func _ready() -> void:
	MetSys.register_storable_object_with_marker(self)


func _on_body_entered(body: Node2D) -> void:
	var samus: Samus = body as Samus
	self.collected_collectible.connect(samus._on_collected_collectible)
	collected_collectible.emit(self)
	MetSys.store_object(self)
	queue_free()
