extends StateMachine

onready var idle := $Idle
onready var crouch := $Crouch
onready var move := $Move
onready var spin_jump := $SpinJump
onready var jump := $Jump
onready var fall := $Fall
onready var spin_fall := $SpinFall
onready var morph_ball := $MorphBall


func _ready() -> void:
	states_map = {
		"idle": idle,
		"crouch": crouch,
		"move": move,
		"spin_jump": spin_jump,
		"jump": jump,
		"morph_ball": morph_ball,
	}


func _change_state(state_name):
	if not _active:
		return
	if current_state == move:
		jump.initialize(move.velocity)
	._change_state(state_name)


func _input(event):
	current_state.handle_input(event)
