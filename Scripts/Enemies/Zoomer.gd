extends KinematicBody2D

class_name Zoomer

export var direction := 1

onready var collision_shape : CircleShape2D = $CollisionShape2D.shape

var rotating: int
var move := Vector2.ZERO
var speed := 43

func _physics_process(delta: float) -> void:
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
			rotate(PI/32)
			move = move.rotated(PI/32)
			col = move_and_collide(move.rotated(PI / 2) * multiplier)

			if col:
				move = col.normal.rotated(PI / 2)
				rotation = move.angle()
				break
	else:
		move = col.normal.rotated(PI / 2)
		rotation = move.angle()


func _damage() -> void:
	queue_free()


func _on_Hurtbox_area_entered(area):
	print('hit zoomer area')
	_damage()


func _on_Hurtbox_body_entered(body: Node) -> void:
	print('hurt zoomer body')
	print(body.name)
	_damage()
