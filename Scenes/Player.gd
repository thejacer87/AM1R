extends KinematicBody2D

const FLOOR := Vector2.UP
const ACC := 100
const MAX_FALL_SPEED := 300


var gravity
var max_jump_velocity
var min_jump_velocity
var speed
var health := 1
var walk_speed : float = 7.0 * Globals.UNIT_SIZE
var max_jump_height : float = 10 * Globals.UNIT_SIZE
var min_jump_height : float = 1.25 * Globals.UNIT_SIZE
var jump_duration := .5
var velocity := Vector2.ZERO
var input := Vector2.ZERO

func _ready() -> void:
	speed = walk_speed
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)

func _physics_process(delta: float) -> void:

	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input = input.normalized()
	velocity.x = input.x * speed

	if Input.is_action_pressed("jump"):
		velocity.y -= max_jump_height


	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
