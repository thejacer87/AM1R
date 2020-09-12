extends KinematicBody2D

class_name Samus


onready var label = $RichTextLabel
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var animation_tree = $AnimationTree


func _physics_process(_delta):
	label.text = $MotionStateMachine.current_state.get_name()
	mode_label.text = $MorphStateMachine.current_state.get_name()


func _input(event) -> void:
	if event.is_action_pressed("shoot"):
		beam_cannon.fire()
