class_name Pickup
extends Area2D


func _ready():
	for area in Globals.GameMap.get_node("Areas").get_children():
		connect("item_collected", area, "_on_item_collected")


func _on_PickUp_body_entered(samus: Samus) -> void:
	print(samus.name)
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
