class_name Samus
extends KinematicBody2D

export var missile_count = 2
export var energy = 99

var missile_ui
var missile_count_ui
var energy_count_ui
var black_screen
var collected_powerups = []

var _morph_blockers := 0

onready var label = $RichTextLabel
onready var camera = $Camera2D
onready var mode_label = $mode
onready var beam_cannon = $BeamCannon
onready var gameplay_ui := preload("res://Scenes/UI/GameplayUI.tscn")
onready var animation_tree = $AnimationTree
onready var black_screen_scene := preload("res://Scenes/Levels/BlackScreen.tscn")
onready var map := preload("res://Scenes/Map/Map.tscn")
onready var motion_state_machine = $MotionStateMachine
onready var morph_state_machine = $MorphStateMachine


func _ready() -> void:
	Globals.Samus = self
	var ui = load("res://Scenes/UI/GameplayUI.tscn").instance()
	Globals.UI.add_child(ui)
	energy_count_ui = Globals.GameplayUI.get_node("VBoxContainer/Energy/EnergyCount")
	missile_ui = Globals.GameplayUI.get_node("VBoxContainer/Missiles")
	missile_count_ui = missile_ui.get_node("MissileCount")
	missile_ui.hide()


func _physics_process(_delta):
	label.text = motion_state_machine.current_state.get_name()
	mode_label.text = morph_state_machine.current_state.get_name()
	if has_powerup("missiles"):
		missile_ui.show()
		missile_count_ui.text = String(missile_count)
	energy_count_ui.text = String(energy)

	if Input.is_action_just_pressed("start"):
		get_tree().paused = true
		add_child(map.instance())


func bomb_jump() -> void:
	if morph_state_machine.current_state == Globals.STATES["Morph"].states_map["morph_ball"]:
		motion_state_machine._change_state("bomb_jump")


func animate_save() -> void:
	print('anmiate save')


func add_energy(amount: int) -> void:
	energy += amount


func add_missiles(amount: int) -> void:
	missile_count += amount


func has_powerup(powerup: String) -> bool:
	return collected_powerups.has(powerup)


func can_morph() -> bool:
	return _morph_blockers < 1


func collect_powerup(powerup: String) -> void:
	if not collected_powerups.has(powerup):
		collected_powerups.push_back(powerup)


func save(load_position) -> Dictionary:
	var save = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": load_position.x,
		"pos_y": load_position.y,
		"missile_count": missile_count,
		"collected_powerups": collected_powerups
	}
	return save


func _damage(amount: int) -> void:
	# Stun/flash and make invulnerable for a half second?
	energy -= amount


func _show_black_screen() -> void:
	# Add the black screen to Samus. Then make sure Samus is in the front of
	# the tree before showing the black screen.
	var level = get_parent()
	add_child(black_screen_scene.instance())
	black_screen = get_node("BlackScreen")
	level.move_child(self, level.get_child_count())
	black_screen.fade_in()


func _hide_black_screen() -> void:
	black_screen.fade_out()
	var level = get_parent()
	var doors = level.get_node("Doors")
	level.move_child(doors, level.get_child_count())


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		_damage(area.damage)


func _on_transition_started(old, new, door, left) -> void:
	_show_black_screen()
	camera.connect("transition_completed", self, "_on_transition_completed")
	camera.connect("transition_completed", door, "_on_transition_completed")
	camera.transition(old, new, door, left)


func _on_transition_completed() -> void:
	_hide_black_screen()


func _on_MorphCheckArea_body_entered(body: Node) -> void:
	_morph_blockers += 1


func _on_MorphCheckArea_body_exited(body: Node) -> void:
	if _morph_blockers <= 0:
		_morph_blockers = 0
	else:
		_morph_blockers -= 1
