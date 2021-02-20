class_name Samus
extends KinematicBody2D

export var missile_count = 2
export var energy = 99

var missile_ui
var missile_count_ui
var energy_count_ui
var current_room: Room setget ,get_current_room
var current_room_path: String setget set_current_room_path
var collected_powerups = []

var _morph_blockers := 0
var _black_screen
var _test

onready var label = $RichTextLabel
onready var camera = $MainCamera
onready var mode_label = $mode
onready var gameplay_ui := preload("res://src/interface/GameplayUI.tscn")
onready var animation_tree = $AnimationTree
onready var black_screen_scene := preload("res://src/areas/BlackScreen.tscn")
onready var map := preload("res://src/map/Map.tscn")
onready var motion_state_machine = $MotionStateMachine
onready var morph_state_machine = $MorphStateMachine


func _ready() -> void:
	Globals.Samus = self
	var ui = load("res://src/interface/GameplayUI.tscn").instance()
	Globals.UI.add_child(ui)
	energy_count_ui = Globals.GameplayUI.get_node("VBoxContainer/Energy/EnergyCount")
	missile_ui = Globals.GameplayUI.get_node("VBoxContainer/Missiles")
	missile_count_ui = missile_ui.get_node("MissileCount")
	missile_ui.hide()


func _physics_process(_delta: float) -> void:
	label.text = motion_state_machine.current_state.get_name()
	mode_label.text = morph_state_machine.current_state.get_name()
	if has_powerup("missiles"):
		missile_ui.show()
		missile_count_ui.text = String(missile_count)
	energy_count_ui.text = String(energy)

	if Input.is_action_just_pressed("start"):
		get_tree().paused = true
		get_tree().get_root().add_child(map.instance())


func bind_camera_limits() -> void:
	if current_room_path:
		var room = get_current_room()
		camera.set_camera_bounds(room)
		room.activate()


func get_current_room() -> Room:
	return (get_node(current_room_path) if get_node(current_room_path) else get_node("../" + current_room_path)) as Room


func set_current_room_path(path: String) -> void:
	current_room_path = path


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
		"samus": {
			"filename": get_filename(),
			"missile_count": missile_count,
			"collected_powerups": collected_powerups,
			"pos_x": load_position.x,
			"pos_y": load_position.y,
			"current_room_path": current_room_path,
		},
		"area": {
			"filename": get_parent().get_filename(),
		},
	}
	return save


func _damage(amount: int) -> void:
	# Stun/flash and make invulnerable for a half second?
	energy -= amount
	if energy < 30:
		print("play alarm")
		pass
	if energy <= 0:
		_die()


func _die() -> void:
	print("animate death")
	print("show menu")
	get_tree().get_root().get_node("Main").restart()


func _show_black_screen() -> void:
	_black_screen = black_screen_scene.instance()
	Globals.GameViewport.add_child(_black_screen)
	_black_screen.fade_in()


func _hide_black_screen() -> void:
	_black_screen.fade_out()


func _on_transition_out_started() -> void:
	hide()
	camera.set_deferred("current", false)
	morph_state_machine._change_state("neutral")
	set_physics_process(false)
	set_process(false)


func _on_transition_in_started(room: String) -> void:
	set_current_room_path(room)
	bind_camera_limits()


func _on_transition_in_finished() -> void:
	camera.set_deferred("current", true)
	var elevator = get_current_room().get_node("Elevator")
	global_position = elevator.get_platform().global_position
	position.y -= 24
	set_process(true)
	set_physics_process(true)
	show()


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		_damage(area.damage)


func _on_transition_started(old_room: Room, new_room: Room, door, direction) -> void:
	door.z_index = VisualServer.CANVAS_ITEM_Z_MAX
	get_tree().paused = true
	_show_black_screen()
	camera.connect("transition_completed", self, "_on_transition_completed")
	_black_screen.connect("fade_out_finished", door, "_on_transition_completed")
	yield(_black_screen, "fade_in_finished")
	old_room.deactivate()
	camera.transition(new_room, door, direction)
	new_room.activate()
	set_current_room_path(new_room.get_path())


func _on_transition_completed() -> void:
	_hide_black_screen()
	yield(_black_screen, "fade_out_finished")
	get_tree().paused = false


func _on_MorphCheckArea_body_entered(_body: Node) -> void:
	_morph_blockers += 1


func _on_MorphCheckArea_body_exited(_body: Node) -> void:
	if _morph_blockers <= 0:
		_morph_blockers = 0
	else:
		_morph_blockers -= 1
