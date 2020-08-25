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
var input := Vector2.ZERO


onready var label = $RichTextLabel
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready() -> void:
	speed = walk_speed
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func _apply_gravity(delta: float) -> void:
	velocity.y = velocity.y + gravity * delta if not is_on_floor() else 0
	print(velocity.y)
	print(is_on_floor())


func _handle_move_input() -> void:
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()

	velocity.x = input.x * speed


func _apply_movement(delta: float) -> void:
	var snap = Vector2.ZERO
#	move_and_collide(velocity)
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR)
#	velocity = move_and_slide(velocity, FLOOR)
