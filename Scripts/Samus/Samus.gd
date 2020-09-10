extends KinematicBody2D

class_name Samus


const BEAM := preload("res://Scenes/Beam.tscn")

onready var label = $RichTextLabel
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var animation_tree = $AnimationTree


func _physics_process(_delta):
	label.text = $MotionStateMachine.current_state.get_name()
	mode_label.text = $MorphStateMachine.current_state.get_name()


func _input(event) -> void:
	if event.is_action_pressed("shoot"):
		var beam = BEAM.instance()
		get_parent().add_child(beam)
		beam.direction = beam_cannon.get_barrel_direction()
		beam.position = beam_cannon.global_position
