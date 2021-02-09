extends PowerUp

const MISSILE_UPGRADE_AMOUNT := 5

func _on_PowerUp_body_entered(samus: Samus) -> void:
	samus.add_missiles(MISSILE_UPGRADE_AMOUNT)
	._on_PowerUp_body_entered(samus)
