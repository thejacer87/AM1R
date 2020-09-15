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
	Globals.STATES['Morph'] = self
