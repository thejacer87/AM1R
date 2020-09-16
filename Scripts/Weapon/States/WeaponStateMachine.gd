extends StateMachine


onready var beam := $Beam
onready var missile := $Missile
onready var bomb := $Bomb

func _ready() -> void:
	states_map = {
		"beam": beam,
		"missile": missile,
		"bomb": bomb,
	}
	Globals.STATES['Weapon'] = self
