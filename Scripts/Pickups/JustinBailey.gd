extends PowerUp


func _on_PowerUp_body_entered(samus: Samus) -> void:
	get_tree().paused = true
	samus.collect_powerup("morph_ball")
	samus.collect_powerup("missiles")
	samus.collect_powerup("bomb")
	samus.collect_powerup("high_jump")
	samus.collect_powerup("long_beam")
	samus.add_missiles(999)
	print("collected justin bailey")
	# change to longer time to match the jingle
	# play jingle and show something
	queue_free()
	get_tree().paused = false
