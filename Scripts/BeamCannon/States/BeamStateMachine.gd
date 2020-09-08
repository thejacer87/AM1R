extends StateMachine


onready var beam := $Beam
onready var missile := $Missile

func _ready() -> void:
	states_map = {
		"beam": beam,
		"missile": missile,
	}
