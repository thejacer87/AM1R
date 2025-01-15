class_name PowerItem
extends Area2D

signal collected_power_item(power_item: String)

@export var power_item_name: String


func _ready() -> void:
	MetSys.register_storable_object_with_marker(self)


func _on_body_entered(body: Node2D) -> void:
	var samus: Samus = body as Samus
	self.collected_power_item.connect(samus._on_collected_power_item)
	collected_power_item.emit(power_item_name)
	MetSys.store_object(self)
	MetSys.discover_cell_group(0)
	queue_free()
