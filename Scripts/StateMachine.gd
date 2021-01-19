extends Node

class_name StateMachine

signal state_changed(current_state)

export(NodePath) var START_STATE

var states_map = {}
var current_state = null
var _active = false setget set_active


func _ready() -> void:
	for child in get_children():
		child.connect("finished", self, "_change_state")
	initialize(START_STATE)


func initialize(start_state: NodePath) -> void:
	set_active(true)
	current_state = get_node(start_state)
	current_state.enter()


func set_active(value) -> void:
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		current_state = null


func _input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _physics_process(delta: float) -> void:
	current_state.update(delta)


func _change_state(state_name):
	if not _active:
		return
	if state_name == "morph_ball" and not (owner as Samus).has_powerup("morph_ball"):
		return

	current_state.exit()

	current_state = states_map[state_name]
	emit_signal("state_changed", current_state)

	current_state.enter()
