class_name PowerUp
extends Area2D


export var powerup_name: String


func _on_PowerUp_body_entered(samus: Samus) -> void:
	get_tree().paused = true
	samus.collect_powerup(powerup_name)
	print("collected " + powerup_name)
	# change to longer time to match the jingle
#	yield(get_tree().create_timer(.5), "timeout")
	# play jingle and show something
	queue_free()
	get_tree().paused = false
