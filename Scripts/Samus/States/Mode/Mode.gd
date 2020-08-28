extends State

class_name ModeState


var blend := "parameters/%s/blend_position"


onready var neutral_collision = owner.get_node("NeutralCollision")
onready var crouch_collision = owner.get_node("CrouchCollision")
onready var morph_ball_collision = owner.get_node("MorphBallCollision")
onready var animation_tree = owner.get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")


func handle_input(event):
	return .handle_input(event)


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func _set_collision_state(collision):
	owner.get_node("NeutralCollision").set_deferred("disabled", collision != "Neutral")
	owner.get_node("CrouchCollision").set_deferred("disabled", collision != "Crouch")
	owner.get_node("MorphBallCollision").set_deferred("disabled", collision != "MorphBall")
