extends StateMachine


func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("shoot")
	add_state("jumping")
	add_state("wall_cling")
	call_deferred("set_state", states.idle)


func _input(event) -> void:
	if [states.idle, states.run].has(state):
		var input = Vector2.ZERO
		input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input = input.normalized()

		if input != Vector2.ZERO:
			parent.animation_tree.set("parameters/Idle/blend_position", input)
			parent.animation_tree.set("parameters/Run/blend_position", input)
			parent.animation_state.travel("Run")
#			parent.velocity = parent.velocity.move_toward(input * parent.speed, parent.ACC * delta)
		else:
			parent.animation_state.travel("Idle")
			parent.velocity = Vector2.ZERO


func _state_logic(delta) -> void:
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent.run()
	parent.jump()
	parent.move(delta)


func _get_transition(_delta) -> String:
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
	return ""

func _enter_state(new_state, old_state) -> void:
	match new_state:
		states.idle:
			parent.animation_tree.set("parameters/Idle/blend_position", parent.input)
			parent.animation_state.travel("Idle")
		states.run:
			parent.animation_tree.set("parameters/Run/blend_position", parent.input)
			parent.animation_state.travel("Run")
		states.jump:
			parent.animation_tree.set("parameters/Jump/blend_position", parent.input)
			parent.animation_state.travel("Jump")


func _exit_state(old_state, new_state) -> void:
	pass
