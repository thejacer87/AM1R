extends StateMachine

onready var idle := $Idle
onready var move := $Move
onready var jump := $Jump
onready var fall := $Fall


func _ready() -> void:
	states_map = {
		"idle": idle,
		"move": move,
		"jump": jump,
		"fall": fall,
	}


func _change_state(state_name):
	if not _active:
		return
	if current_state == move and state_name == "jump":
		jump.initialize(move.velocity)
	if current_state == jump and state_name == "fall":
		fall.initialize(jump.velocity)             
	._change_state(state_name)


func _input(event: InputEvent):
	current_state.handle_input(event)
