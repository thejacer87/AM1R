extends CanvasLayer

signal visited_room(room)

export var mini := false

const SPEED := -256
const ROOM_SIZE := 8
const OFFSET_MINI := Vector2(28, 8)
const OFFSET_ZOOM_OUT := Vector2(168, 111)
const SCALE_MINI := Vector2(1, 1)
const SCALE_ZOOMED := Vector2(4, 4)
const SCALE_DEFAULT := Vector2(1, 1)

var _zoomed := true
var _room_coord
var _samus

onready var areas := $Areas
onready var camera := $Camera2D


func _ready() -> void:
	Globals.GameMap = self
	scale = SCALE_ZOOMED
	_update_current_room()
	offset = _room_coord
	for area in areas.get_children():
		connect("visited_room", area, "_on_visited_room")


func _physics_process(_delta: float) -> void:
	# this might not be efficient to update every frame...
	_update_current_room()

	if mini:
		scale = SCALE_MINI
		offset = -_convert_to_map_position() + OFFSET_MINI
	elif Input.is_action_just_pressed("start"):
		if get_tree().paused:
			hide_map()
		else:
			show_map()
		get_tree().paused = not get_tree().paused


func _process(delta: float) -> void:
	if _zoomed and not mini:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		var move = Vector2(input_direction.x * delta * SPEED, input_direction.y * delta * SPEED)
		offset += move
		offset = Vector2(clamp(offset.x, -Globals.SCREEN_WIDTH, Globals.SCREEN_WIDTH / 2), clamp(offset.y, -Globals.SCREEN_HEIGHT * 2, Globals.SCREEN_HEIGHT * 2.9))


func _input(event: InputEvent) -> void:
	if get_tree().paused and event.is_action_pressed("jump") and not mini:
		_zoom_and_offset()


func show_map():
	_zoomed = false
	_zoom_and_offset()
	layer = 1


func hide_map():
	layer = -10


func _update_current_room() -> void:
	_samus = Globals.Samus
	var position = _convert_to_map_position()
	emit_signal("visited_room", position)
	_room_coord = position * -SCALE_ZOOMED
	_room_coord += Vector2(Globals.SCREEN_WIDTH / 2 - 16, Globals.SCREEN_HEIGHT / 2 - 20)
	$current.position = position


func _convert_to_map_position() -> Vector2:
	if _samus:
		var pos = _samus.global_position / 32
		pos.x = ROOM_SIZE * floor(abs(pos.x / ROOM_SIZE))
		pos.y = ROOM_SIZE * floor(abs(pos.y / ROOM_SIZE))
		return pos

	return Vector2.ZERO


func _zoom_and_offset(default := true) -> void:
	if _zoomed:
		scale = SCALE_DEFAULT
		offset = OFFSET_ZOOM_OUT
	else:
		scale = SCALE_ZOOMED
		offset = _room_coord
	_zoomed = not _zoomed
