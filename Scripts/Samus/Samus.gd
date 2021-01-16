extends KinematicBody2D

class_name Samus


onready var label = $RichTextLabel
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var animation_tree = $AnimationTree
onready var motion_state_machine = $MotionStateMachine
onready var morph_state_machine = $MorphStateMachine
onready var camera = $Camera2D
onready var black_screen_scene := preload("res://Scenes/Levels/BlackScreen.tscn")

var ui
var black_screen

export var missile_count = 0


func _ready() -> void:
	ui = get_tree().get_root().get_node("Playground/UI/UI/VBoxContainer/HBoxContainer/MissileCount")


func _physics_process(_delta):
#	label.text = motion_state_machine.current_state.get_name()
#	mode_label.text = morph_state_machine.current_state.get_name()
	ui.text = String(missile_count)


func bomb_jump() -> void:
	if morph_state_machine.current_state == Globals.STATES["Morph"].states_map["morph_ball"]:
		motion_state_machine._change_state("bomb_jump")


func show_black_screen() -> void:
	# Add the black screen to the level. Then make sure Samus is in the front of
	# the tree before showing the black screen.
	var level = get_parent()
	level.add_child(black_screen_scene.instance())
	black_screen = level.get_node("BlackScreen")
	level.move_child(self, level.get_child_count())
	black_screen.show()


func hide_black_screen() -> void:
	black_screen.queue_free()
	var level = get_parent()
	for door in get_tree().get_nodes_in_group("DOOR"):
		level.move_child(door, level.get_child_count())


func animate_save()-> void:
	print('anmiate save')


func save(load_position) -> Dictionary:
	var save = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": load_position.x,
		"pos_y": load_position.y,
		"camera": $Camera2D,
		"missile_count": missile_count
	}
	return save
