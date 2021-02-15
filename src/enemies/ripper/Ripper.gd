class_name Ripper
extends Enemy

const SPEED := 40

var velocity := Vector2.ZERO

var _direction: int = Globals.Directions.LEFT

onready var sprite := $Sprite
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
	sprite.flip_h = not sprite.flip_h
	velocity = Vector2.ZERO


func stop() -> void:
	set_physics_process(false)


func start() -> void:
	set_physics_process(true)


func _on_Hurtbox_area_entered(_area: Area2D):
	if true: #ice ice baby
		print('freeze only')
	else:
		print('doink')
