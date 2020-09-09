extends MotionState

class_name AirborneState

onready var wall_stick = owner.get_node("WallStickTimer")

var max_jump_velocity
var min_jump_velocity
var aerial_speed : float = 4 * Globals.UNIT_SIZE
var enter_velocity := Vector2.ZERO
var wall_direction := 1


func initialize(velocity: Vector2) -> void:
	enter_velocity = velocity


func _ready() -> void:
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func update(delta: float) -> void:
	if owner.is_on_wall():
		wall_stick.start()
		wall_direction = get_wall_collided()
	.update(delta)


func handle_input(event: InputEvent):
	if not in_morph_ball():
		if event.is_action_pressed("jump") and wall_stick.time_left > 0:
			var input_direction = get_input_direction()
			var dir = sign(input_direction.x)
			if wall_direction != sign(input_direction.x):
				wall_stick.stop()
				velocity.x = 1.75 * -wall_direction * aerial_speed
				velocity.y = max_jump_velocity * .8
				print('wall jump bro')
	return .handle_input(event)


func get_wall_collided() -> int:
	for i in range(owner.get_slide_count()):
		var collision = owner.get_slide_collision(i)
		if collision.normal.x > 0:
			return -1
		elif collision.normal.x < 0:
			return 1
	return 0
