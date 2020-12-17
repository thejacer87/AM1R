extends KinematicBody2D

class_name Samus


onready var label = $RichTextLabel
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var animation_tree = $AnimationTree
onready var motion_state_machine = $MotionStateMachine
onready var morph_state_machine = $MorphStateMachine

func _ready() -> void:
	var camera = load("res://Camera.tscn")
	add_child(camera.instance())

func _physics_process(_delta):
	label.text = motion_state_machine.current_state.get_name()
	mode_label.text = morph_state_machine.current_state.get_name()

func bomb_jump() -> void:
	if morph_state_machine.current_state == Globals.STATES["Morph"].states_map["morph_ball"]:
		motion_state_machine._change_state("bomb_jump")

func save(load_position) -> Dictionary:
	var save = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": load_position.x,
		"pos_y": load_position.y,
		"camera": $Camera2D
	}
	return save
