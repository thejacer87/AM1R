extends StateMachine


onready var beam := $Beam
onready var missile := $Missile
onready var bomb := $Bomb
onready var power_bomb := $PowerBomb

func _ready() -> void:
	states_map = {
		"beam": beam,
		"missile": missile,
		"bomb": bomb,
		"power_bomb": power_bomb,
	}
	Globals.STATES['Weapon'] = self
