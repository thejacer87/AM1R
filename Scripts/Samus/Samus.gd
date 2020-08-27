extends KinematicBody2D

class_name Samus


signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

const FLOOR := Vector2.UP
const ACC := 100
const MAX_FALL_SPEED := 300


var gravity
var max_jump_velocity
var min_jump_velocity
var health := 1
var run_speed : float = 10 * Globals.UNIT_SIZE
var aerial_speed : float = 5 * Globals.UNIT_SIZE
var max_jump_height : float = 7.75 * Globals.UNIT_SIZE
var min_jump_height : float = 2.25 * Globals.UNIT_SIZE
var jump_duration := .8
var velocity := Vector2.ZERO
var input := Vector2.ZERO
var in_morph_ball := false
var is_crouched := false
var travel := "Idle"
var blend := "parameters/%s/blend_position"


onready var label = $RichTextLabel
onready var mode_label = $mode
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var movement_sm = $MovementStateMachine
onready var modes_sm = $ModesStateMachine




func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func _ready() -> void:
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func _apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta


func _handle_move_input() -> void:
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()

	if movement_sm.state.crouch:
		velocity.x = 0
	elif is_on_floor():
		velocity.x = input.x * run_speed
	elif is_on_floor():
		velocity.x = input.x * run_speed
	else:
		pass

	if input.x != 0:
		animation_tree.set(blend % travel, input)

	animation_state.travel(travel)


func _apply_movement(delta: float) -> void:
	velocity = move_and_slide(velocity, FLOOR)



