extends Pickup


func _ready():
	pass


func _on_Pickup_body_entered(samus : Samus):
	samus.missile_count += 2
	queue_free()
