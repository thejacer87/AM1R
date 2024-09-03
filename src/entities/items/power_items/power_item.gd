class_name PowerItem
extends Area2D

signal collected_power_item

@export var power_item_name: String

func _on_body_entered(body: Node2D) -> void:
	print("Collected: " + str(name))
	var samus: Samus = body as Samus
	self.collected_power_item.connect(samus._on_collected_power_item)
	collected_power_item.emit()
	emit_signal("collected_power_item", power_item_name)

	queue_free()
