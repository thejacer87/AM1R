extends Area2D

class_name PowerUp

export var powerup_name: String

func _ready() -> void:
	pass


func _on_PowerUp_body_entered(samus: Samus) -> void:
	get_tree().paused = true
	samus.collect_powerup(powerup_name)
	print("collected " + powerup_name)
	yield(get_tree().create_timer(2.5), "timeout")
	# play jingle and show something
	queue_free()
	get_tree().paused = false