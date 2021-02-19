extends CanvasLayer

const SPEED := -256
const ROOM_SIZE := 8
const WORLD_OFFSET := Vector2(168, 111)
const SCALE := Vector2(4, 4)
const ZOOMED_SCALE := Vector2(4, 4)

var _zoomed := true
var _room_coord
var _samus

onready var camera := $Camera2D


func _ready() -> void:
	scale = ZOOMED_SCALE
	_update_current_room()
	offset = _room_coord


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().paused = false
		queue_free()

	_update_current_room()


func _process(delta: float) -> void:
	if _zoomed:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		var move = Vector2(input_direction.x * delta * SPEED, input_direction.y * delta * SPEED)
		offset += move
		offset = Vector2(clamp(offset.x, -Globals.SCREEN_WIDTH * 2, -450), clamp(offset.y, -Globals.SCREEN_HEIGHT * 2.9, -64))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if _zoomed:
			scale = Vector2(1, 1)
			offset = Vector2.ZERO
		else:
			scale = ZOOMED_SCALE
			offset = _room_coord
		_zoomed = not _zoomed


func _update_current_room() -> void:
	_samus = Globals.Samus
	var position = _convert_to_map_position()
	_room_coord = position * -SCALE
	_room_coord += Vector2(Globals.SCREEN_WIDTH / 2 - 16, Globals.SCREEN_HEIGHT / 2 - 20)
	$current.rect_position = position


func _convert_to_map_position() -> Vector2:
	var pos = _samus.global_position / 32
	pos.x = ROOM_SIZE * floor(abs(pos.x / ROOM_SIZE))
	pos.y = ROOM_SIZE * floor(abs(pos.y / ROOM_SIZE))
	pos += WORLD_OFFSET
	return pos
