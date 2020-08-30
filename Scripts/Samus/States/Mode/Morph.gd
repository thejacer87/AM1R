extends State

class_name MorphState


onready var neutral_collision = owner.get_node("NeutralCollision")
onready var crouch_collision = owner.get_node("CrouchCollision")
onready var morph_ball_collision = owner.get_node("MorphBallCollision")
onready var animation_state = owner.get_node("AnimationTree").get("parameters/playback")


func handle_input(event):
	return .handle_input(event)


func _set_collision_state(collision):
	owner.get_node("NeutralCollision").set_deferred("disabled", collision != "Neutral")
	owner.get_node("CrouchCollision").set_deferred("disabled", collision != "Crouch")
	owner.get_node("MorphBallCollision").set_deferred("disabled", collision != "MorphBall")
