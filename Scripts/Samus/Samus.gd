extends KinematicBody2D

class_name Samus


onready var label = $RichTextLabel
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var animation_tree = $AnimationTree


func _physics_process(_delta):
	label.text = $MotionStateMachine.current_state.get_name()
	mode_label.text = $MorphStateMachine.current_state.get_name()

func bomb_jump() -> void:
	$MotionStateMachine.current_state.velocity.y = -150
