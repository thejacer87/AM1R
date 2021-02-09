extends MotionState

class_name AirborneState

onready var wall_stick = owner.get_node("WallStickTimer")

var max_jump_velocity
var min_jump_velocity
var high_jump_multiplier = 1.578
var is_spinning := false
var aerial_speed := 4 * Globals.UNIT_SIZE
var morph_aerial_speed := 100 * Globals.UNIT_SIZE
var enter_velocity := Vector2.ZERO
var wall_direction := 1


func initialize(velocity: Vector2) -> void:
	enter_velocity = velocity


func _ready() -> void:
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func update(delta: float) -> void:
	# Kinda works. will need re-doing.
	if Globals.Samus.has_powerup("high_jump"):
		max_jump_velocity = -sqrt(2 * gravity * max_jump_height * high_jump_multiplier)
	if owner.is_on_wall():
		wall_stick.start()
		wall_direction = get_wall_collided()

	var input_direction = get_input_direction()
	if input_direction:
		update_blend_positions(["Fall", "Jump", "SpinJump", "Idle", "Move"])
		if sign(velocity.x) != sign(input_direction.x):
			velocity.x = aerial_speed * sign(input_direction.x)
	.update(delta)


func handle_input(event: InputEvent):
	if not in_morph_ball():
		if is_spinning:
			var input_direction = get_input_direction()
			# Stop spinning
			if input_direction.y == -1:
				var facing = sign(velocity.x)
				animation_state.travel("Jump") if velocity.y > 0 else animation_state.travel("Fall")
				is_spinning = false
			# Aim down
			if input_direction.y == 1:
				is_spinning = false
			# Wall jump
			if event.is_action_pressed("jump") and wall_stick.time_left > 0:
				if wall_direction == sign(input_direction.x):
					wall_stick.stop()
					velocity.x = 1.75 * -wall_direction * aerial_speed
					velocity.y = max_jump_velocity * .8
		else:
			if Input.is_action_just_pressed("jump"):
				var facing = sign(velocity.x)
				# animation_state.travel("SpinJump")
				# velocity.x = facing * 100

	return .handle_input(event)


func get_wall_collided() -> int:
	for i in range(owner.get_slide_count()):
		var collision = owner.get_slide_collision(i)
		if collision.normal.x > 0:
			return 1
		elif collision.normal.x < 0:
			return -1
	return 0
