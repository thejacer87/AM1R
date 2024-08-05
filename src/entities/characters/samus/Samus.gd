class_name Samus
extends CharacterBody2D

enum facing {LEFT, RIGHT}

const SPEED := 200.0
const JUMP_VELOCITY := -275.0


@export var energy := 99
@export var GRAVITY := 500.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var looking := facing.RIGHT

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

		
	if direction:
		if not is_on_floor():
			velocity.x = direction * SPEED * 0.666667
		else:
			velocity.x = direction * SPEED
			
		if direction > 0.0:
			animated_sprite_2d.flip_h = false
			if not is_on_floor():
				animated_sprite_2d.play("jump_spin_right")
			else:
				animated_sprite_2d.play("run_right")
			looking = facing.RIGHT
		else:
			animated_sprite_2d.flip_h = true
			if not is_on_floor():
				animated_sprite_2d.play("jump_spin_left")
			else:
				animated_sprite_2d.play("run_left")
			looking = facing.LEFT
	elif is_on_floor():
		if looking == facing.LEFT:
			animated_sprite_2d.play("idle_left")
		else:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("idle_right")
		velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, 0, 5)

	move_and_slide()

func damage(base_damage: int) -> void:
	
	energy -= base_damage
