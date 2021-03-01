class_name PowerUp
extends Area2D

signal item_collected(position)

export var powerup_name: String


func _ready():
	for area in Globals.GameMap.get_node("Areas").get_children():
		connect("item_collected", area, "_on_item_collected")


func _on_PowerUp_body_entered(samus: Samus) -> void:
	get_tree().paused = true
	samus.collect_powerup(powerup_name)
	print("collected " + powerup_name)
	emit_signal("item_collected", position)
	# change to longer time to match the jingle
#	yield(get_tree().create_timer(.5), "timeout")
	# play jingle and show something
	queue_free()
	get_tree().paused = false
