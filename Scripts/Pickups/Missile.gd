extends Pickup


func _ready():
	pass


func _on_Pickup_body_entered(samus : Samus):
	samus.missile_count += 2
	samus.collect_powerup("morph_ball")
	samus.collect_powerup("high_jump")
	samus.collect_powerup("long_beam")
	queue_free()
