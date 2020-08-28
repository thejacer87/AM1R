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
		"fall": fall,
		"spin_fall": spin_fall,
		"morph_ball": morph_ball,
	}


func _change_state(state_name):
	if not _active:
		return
	if state_name in ["jump", "spin_jump"]:
		states_stack.push_front(states_map[state_name])
#	if state_name == "jump" and current_state == run:
#		jump.initialize(run.speed, run.velocity)
	._change_state(state_name)


func _input(event):
	current_state.handle_input(event)


#func _state_logic(delta: float) -> void:
#	parent._handle_move_input()
#	parent._apply_gravity(delta)
#	parent._apply_movement(delta)


#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("morph"):
#		state = states.morph_ball
#
#	if [states.idle, states.run].has(state):
#		if event.is_action_pressed("jump"):
#			parent.velocity.y = parent.max_jump_velocity
#
#	if [states.jump, states.spin_jump].has(state):
#		if event.is_action_released("jump") && parent.velocity.y < parent.min_jump_velocity:
#			parent.velocity.y = parent.min_jump_velocity
#
#	if [states.idle].has(state):
#		if event.is_action_pressed("down"):
#			parent.is_crouched = true
#
#	if [states.morph_ball].has(state):
#		if event.is_action_pressed("morph"):
#			parent.is_crouched = true
#			parent.in_morph_ball = false
#
#	if [states.crouch].has(state):
#		if event.is_action_pressed("down"):
#			parent.is_crouched = false
#			parent.in_morph_ball = true
#		if event.is_action_pressed("up"):
#			parent.is_crouched = false
#
#
#func _get_transition(delta: float):
#	match state:
#		states.idle:
#			if !parent.is_on_floor():
#				if parent.velocity.y < 0:
#					return states.jump
#				elif parent.velocity.y > 0:
#					return states.fall
#			elif parent.velocity.x != 0:
#				return states.run
#			elif parent.in_morph_ball:
#				return states.morph_ball
#			elif parent.is_crouched:
#				return states.crouch
#		states.run:
#			if !parent.is_on_floor():
#				if parent.velocity.y < 0:
#					return states.spin_jump
#				elif parent.velocity.y > 0:
#					return states.fall
#			elif parent.velocity.x == 0:
#				return states.idle
#			elif parent.in_morph_ball:
#				return states.morph_ball
#		states.jump:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y >= 0:
#				return states.fall
#			elif parent.in_morph_ball:
#				return states.morph_ball
#		states.spin_jump:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y >= 0:
#				return states.spin_fall
#			elif parent.in_morph_ball:
#				return states.morph_ball
#		states.fall:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y < 0:
#				return states.jump
#			elif parent.in_morph_ball:
#				return states.morph_ball
#		states.spin_fall:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y < 0:
#				return states.spin_jump
#			elif parent.in_morph_ball:
#				return states.morph_ball
#		states.morph_ball:
#			if not parent.in_morph_ball:
#				if parent.is_on_floor():
#					return states.crouch
#				else:
#					return states.fall
#		states.crouch:
#			if not parent.is_crouched:
#				return states.idle
#			if parent.in_morph_ball:
#				return states.morph_ball
#	return null
#
#
#func _enter_state(new_state, old_state) -> void:
#	match new_state:
#		states.idle:
#			parent.enable_default_collision()
#			parent.travel = "Idle"
#		states.run:
#			parent.enable_default_collision()
#			parent.travel = "Run"
#		states.jump:
#			parent.enable_default_collision()
#			parent.travel = "SpinJump"
#		states.spin_jump:
#			parent.enable_default_collision()
#			parent.travel = "SpinJump"
#		states.fall:
#			parent.enable_default_collision()
#			parent.travel = "Idle"
#		states.spin_fall:
#			parent.enable_default_collision()
#			parent.travel = "SpinJump"
#		states.morph_ball:
#			parent.enable_morph_ball_collision()
#			parent.travel = "MorphBall"
#		states.crouch:
#			parent.enable_crouch_collision()
#			parent.travel = "Crouch"
#	parent.label.text = String(state)
#
#
#func _exit_state(old_state, new_state) -> void:
#	pass
