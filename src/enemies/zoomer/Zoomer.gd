class_name Zoomer
extends Enemy

var rotating: int
var move := Vector2.ZERO
var speed := 43
var direction := 1

onready var collision_shape : CircleShape2D = $CollisionShape2D.shape


func _move(delta: float) -> void:
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return

	var col := move_and_collide(move * speed * delta * direction)
	if col and col.normal.rotated(PI / 2).dot(move) < 0.5:
		rotating = 4
		move = col.normal.rotated(PI / 2)
		return

	var pos := position
	var multiplier = collision_shape.radius / 2
	col = move_and_collide(move.rotated(PI / 2) * multiplier)
	if not col:
		for i in 10:
			position = pos
			rotate(PI / 128)
			move = move.rotated(PI / 32)
			col = move_and_collide(move.rotated(PI / 2) * multiplier)

			if col:
				move = col.normal.rotated(PI / 2)
				rotation = move.angle()
				break
			else:
				# Fall down if not on a wall.
				position.y += 3
	else:
		move = col.normal.rotated(PI / 2)
		rotation = move.angle()

