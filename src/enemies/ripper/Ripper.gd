class_name Ripper
extends Enemy

enum Directions {LEFT = -1, RIGHT = 1}

const SPEED := 125

var velocity := Vector2.ZERO

var _direction: int = Directions.LEFT

onready var animated_sprite := $AnimatedSprite
onready var animation_player := $AnimationPlayer


func _move(_delta: float) -> void:
	if is_on_wall():
		animation_player.play("turnaround")

	var motion = Vector2(_direction * SPEED, 0)
	velocity = motion
	velocity = move_and_slide(velocity, Vector2.UP)


func turnaround() -> void:
	_direction *= -1
	animated_sprite.flip_h = not animated_sprite.flip_h
	velocity = Vector2.ZERO


func _on_Hurtbox_area_entered(area: Area2D):
	if true: #ice ice baby
		print('freeze only')
	else:
		print('doink')
