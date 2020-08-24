extends KinematicBody2D
class_name Samus

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


onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready() -> void:
	speed = walk_speed
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func _apply_gravity(delta) -> void:
	pass

func run() -> void:
	if is_on_floor():
		speed = walk_speed

func _handle_move_input -> void:
	pass

func move(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * speed, ACC * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta)


#	var snap = Vector2.DOWN * 8 if not is_jumping else Vector2.ZERO
	velocity.y = min(velocity.y + gravity * delta, MAX_FALL_SPEED)
	var snap = Vector2.ZERO
	move_and_collide(velocity)
#	velocity = move_and_slide_with_snap(velocity, snap, FLOOR, true)
#	velocity = move_and_slide(velocity, FLOOR, true)

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animation_state.travel("Idle")
		velocity.y = max_jump_velocity
	if Input.is_action_just_released("jump") and velocity.y < min_jump_velocity:
		velocity.y = min_jump_velocity
