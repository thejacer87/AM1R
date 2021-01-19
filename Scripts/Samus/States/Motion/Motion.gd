extends State

class_name MotionState

const FLOOR := Vector2.UP
const MAX_FALL_SPEED := 230.0

var gravity : float
var velocity := Vector2.ZERO
var max_jump_height := 5.25 * Globals.UNIT_SIZE
var min_jump_height := 1.25 * Globals.UNIT_SIZE
var jump_duration := 0.4
var blend := "parameters/%s/blend_position"


onready var morph_state_machine = owner.get_node("MorphStateMachine")
onready var animation_tree = owner.get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")


func _ready() -> void:
	gravity = 2 * max_jump_height / pow(jump_duration, 2)


func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()


func update(delta: float) -> void:
	apply_gravity(delta)
	apply_movement()


func update_blend_positions(animations: Array) -> void:
	for animation in animations:
		update_blend_position(animation)


func update_blend_position(animation: String) -> void:
	animation_tree.set(blend % animation, get_input_direction())


func apply_gravity(delta: float) -> void:
	if velocity.y < MAX_FALL_SPEED:
		velocity.y += gravity * delta


func apply_movement() -> void:
	owner.move_and_slide(velocity, FLOOR)


func in_morph_ball() -> bool:
	return morph_state_machine.current_state == Globals.STATES["Morph"].states_map["morph_ball"]


func is_crouched() -> bool:
	return morph_state_machine.current_state == Globals.STATES["Morph"].states_map["crouch"]
