extends Pickup

const MISSILE_AMOUNT := 2


func _on_PickUp_body_entered(samus: Samus):
	samus.add_missiles(MISSILE_AMOUNT)
	._on_PickUp_body_entered(samus)
