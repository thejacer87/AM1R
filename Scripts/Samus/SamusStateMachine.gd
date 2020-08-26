extends StateMachine


func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("shoot")
	add_state("armed")
	add_state("jump")
	add_state("fall")
	add_state("wall_cling")
	call_deferred("set_state", states.idle)


func _state_logic(delta: float) -> void:
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement(delta)


func _input(event: InputEvent) -> void:
	if [states.idle, states.run].has(state):
		if event.is_action_pressed("jump"):
			parent.velocity.y = parent.max_jump_velocity

	if [states.jump].has(state):
		if event.is_action_released("jump") && parent.velocity.y < parent.min_jump_velocity:
			parent.velocity.y = parent.min_jump_velocity


func _get_transition(delta: float):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	return null

func _enter_state(new_state, old_state) -> void:
	match new_state:
		states.idle:
			parent.animation_tree.set("parameters/Idle/blend_position", parent.input)
			parent.animation_state.travel("Idle")
		states.run:
			parent.animation_tree.set("parameters/Run/blend_position", parent.input)
			parent.animation_state.travel("Run")
		states.jump:
			parent.animation_tree.set("parameters/SpinJump/blend_position", parent.input)
			parent.animation_state.travel("SpinJump")
		states.fall:
			parent.animation_tree.set("parameters/Idle/blend_position", parent.input)
			parent.animation_state.travel("Idle")
	parent.label.text = String(state)


func _exit_state(old_state, new_state) -> void:
	pass
