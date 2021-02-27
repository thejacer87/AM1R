extends CanvasLayer

export var mini := false

const SPEED := -256
const ROOM_SIZE := 8
const OFFSET_MINI := Vector2(28, 8)
const OFFSET_WORLD := Vector2(168, 111)
const SCALE_MINI := Vector2(1, 1)
const SCALE_ZOOMED := Vector2(4, 4)
const SCALE_DEFAULT := Vector2(1, 1)

var _zoomed := true
var _room_coord
var _samus

onready var camera := $Camera2D


func _ready() -> void:
	scale = SCALE_ZOOMED
	_update_current_room()
	offset = _room_coord


func _physics_process(_delta: float) -> void:
	_update_current_room()

	if mini:
		scale = SCALE_MINI
		offset = -_convert_to_map_position() + OFFSET_MINI
	elif Input.is_action_just_pressed("start"):
		get_tree().paused = false
		queue_free()



func _process(delta: float) -> void:
	if _zoomed and not mini:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		var move = Vector2(input_direction.x * delta * SPEED, input_direction.y * delta * SPEED)
		offset += move
		offset = Vector2(clamp(offset.x, -Globals.SCREEN_WIDTH * 2, -450), clamp(offset.y, -Globals.SCREEN_HEIGHT * 2.9, -64))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and not mini:
		if _zoomed:
			scale = SCALE_DEFAULT
			offset = Vector2.ZERO
		else:
			scale = SCALE_ZOOMED
			offset = _room_coord
		_zoomed = not _zoomed


func _update_current_room() -> void:
	_samus = Globals.Samus
	var position = _convert_to_map_position()
	_room_coord = position * -SCALE_ZOOMED
	_room_coord += Vector2(Globals.SCREEN_WIDTH / 2 - 16, Globals.SCREEN_HEIGHT / 2 - 20)
	$current.position = position


func _convert_to_map_position() -> Vector2:
	if _samus:
		var pos = _samus.global_position / 32
		pos.x = ROOM_SIZE * floor(abs(pos.x / ROOM_SIZE))
		pos.y = ROOM_SIZE * floor(abs(pos.y / ROOM_SIZE))
		pos += OFFSET_WORLD
		return pos

	return Vector2.ZERO
