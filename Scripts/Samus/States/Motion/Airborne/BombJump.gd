extends AirborneState

class_name BombJumpState

const BOMB_JUMP_HEIGHT := -160


func enter() -> void:
	velocity = Vector2(0, BOMB_JUMP_HEIGHT)


func update(delta: float) -> void:
	if owner.is_on_ceiling():
		velocity.y = 0

	if velocity.y >= 0:
		emit_signal("finished", "fall")

	.update(delta)
