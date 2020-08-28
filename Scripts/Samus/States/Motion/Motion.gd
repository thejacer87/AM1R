extends State

class_name MotionState

const FLOOR := Vector2.UP
const MAX_FALL_SPEED := 2000

var gravity
var velocity := Vector2.ZERO
var health := 1
var aerial_speed : float = 5 * Globals.UNIT_SIZE
var max_jump_height : float = 7.75 * Globals.UNIT_SIZE
var min_jump_height : float = 2.25 * Globals.UNIT_SIZE
var jump_duration := .8
var blend := "parameters/%s/blend_position"


onready var mode_state_machine = owner.get_node("ModeStateMachine")
onready var animation_tree = owner.get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")


func _ready() -> void:
	gravity = 2 * max_jump_height / pow(jump_duration, 2)

#func handle_input(event):
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")

func get_input_direction() -> Vector2:
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()


func update(delta: float) -> void:
	apply_gravity(delta)
	apply_movement()


func apply_gravity(delta: float) -> void:
	if velocity.y < MAX_FALL_SPEED:
		velocity.y += gravity * delta


func apply_movement() -> void:
	owner.move_and_slide(velocity, FLOOR)