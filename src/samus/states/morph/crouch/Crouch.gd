extends MorphState

const CROUCH_STICKYNESS := 0.22


var timer


func enter() -> void:
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = CROUCH_STICKYNESS
	timer.one_shot = true
	add_child(timer)
	animation_state.travel("Crouch")
	._set_collision_state("Crouch")
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		timer.start()


func handle_input(event: InputEvent):
	if (owner as Samus).has_powerup("morph_ball") and (owner as Samus).can_morph() and (event.is_action_pressed("morph_ball") or event.is_action_pressed("down")):
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("up"):
		emit_signal("finished", "neutral")
	if event.is_action_pressed("jump"):
		emit_signal("finished", "neutral")
	return .handle_input(event)


func update(_delta: float) -> void:
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		timer.start()
	if Input.is_action_just_released("right"):
		timer.stop()
	if Input.is_action_just_released("left"):
		timer.stop()


func exit() -> void:
	timer.stop()


func _on_timer_timeout() -> void:
	emit_signal("finished", "neutral")
