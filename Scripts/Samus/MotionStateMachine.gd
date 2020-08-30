extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var jump := $Jump


func _ready() -> void:
	states_map = {
		"idle": idle,
		"move": move,
		"jump": jump,
	}


func _change_state(state_name):
	if not _active:
		return
	if current_state == move:
		jump.initialize(move.velocity)
	._change_state(state_name)


func _input(event: InputEvent):
	current_state.handle_input(event)
