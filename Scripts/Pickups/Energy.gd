extends Pickup

const SMALL_AMOUNT := 5
const LARGE_AMOUNT := 20

export var small := true


func _on_PickUp_body_entered(samus: Samus):
	samus.add_energy(SMALL_AMOUNT if small else LARGE_AMOUNT)
	._on_PickUp_body_entered(samus)
