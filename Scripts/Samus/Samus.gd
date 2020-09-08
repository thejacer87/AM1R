extends KinematicBody2D

class_name Samus


onready var label = $RichTextLabel
onready var mode_label = $mode


func _physics_process(delta):
	label.text = $MotionStateMachine.current_state.get_name()
	mode_label.text = $MorphStateMachine.current_state.get_name()
#	print(label.text)
#	print(label.text)

func _process(delta):
	var test =1
