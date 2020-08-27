extends StateMachine

var is_armed := false
var power_bomb_armed := false


func _ready() -> void:
	add_state("beam")
	add_state("missile")
	add_state("power_bomb")
	call_deferred("set_state", states.beam)


func _state_logic(delta: float) -> void:
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement(delta)


func _input(event: InputEvent) -> void:
	if [states.beam, states.missile].has(state):
		if event.is_action_pressed("arm"):
			is_armed = !is_armed


func _get_transition(delta: float):
	match state:
		states.beam:
			pass
		states.missile:
			pass
	return null

func _enter_state(new_state, old_state) -> void:
	match new_state:
		states.beam:
			pass
		states.missile:
			pass
		states.power_bomb:
			pass
	parent.mode_label.text = String(state)


func _exit_state(old_state, new_state) -> void:
	pass
