extends MorphState

const CROUCH_STICKYNESS := 0.33


onready var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = CROUCH_STICKYNESS
	timer.one_shot = true
	add_child(timer)


func enter() -> void:
	animation_state.travel("Crouch")
	._set_collision_state("Crouch")


func handle_input(event: InputEvent):
	if event.is_action_pressed("morph_ball") or event.is_action_pressed("down"):
		emit_signal("finished", "morph_ball")
	if event.is_action_pressed("up"):
		emit_signal("finished", "neutral")
	return .handle_input(event)


func update(delta: float) -> void:
	# TODO: if moving in morphball, then morph out to crouch. this wont fire if already holding left/right... FIX IT!!	
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
