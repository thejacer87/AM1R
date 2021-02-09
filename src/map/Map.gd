extends CanvasLayer

const SPEED := -288

var _zoomed := true
var _room_coord
var _samus

onready var camera := $Camera2D


func _ready() -> void:
#	_samus = Globals.Samus
	_room_coord = Vector2(-250, -150)
	offset = _room_coord


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().paused = false
		queue_free()


func _process(delta: float) -> void:
	if _zoomed:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		var move = Vector2(input_direction.x * delta * SPEED, input_direction.y * delta * SPEED)
		offset += move
		offset = Vector2(clamp(offset.x, -Globals.SCREEN_WIDTH, 0), clamp(offset.y, -Globals.SCREEN_HEIGHT, 0))
#	print(offset)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if _zoomed:
			scale = Vector2(1, 1)
			offset = Vector2.ZERO
		else:
			scale = Vector2(2, 2)
			offset = _room_coord
		_zoomed = not _zoomed
