extends StateMachine

onready var neutral := $Neutral
onready var crouch := $Crouch
onready var morph_ball := $MorphBall

func _ready() -> void:
	states_map = {
		"neutral": neutral,
		"crouch": crouch,
		"morph_ball": morph_ball,
	}

func _change_state(state_name):
	._change_state(state_name)

func handle_input(event):
	return .handle_input(event)
