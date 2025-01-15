extends Control
# The size of the window in cells.
var SIZE: Vector2i


@onready var hud: HUD = %HUD


var map_view: MapView
var player_location: Node2D
var offset: Vector2i


func _ready() -> void:
	# Cellular size is total size divided by cell size.
	SIZE = size / MetSys.CELL_SIZE
	map_view = MetSys.make_map_view(self, -SIZE / 2, SIZE, 0)
	
	# Create player location. We need a reference to update its offset.
	player_location = MetSys.add_player_location(self)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu_0") or Input.is_action_just_pressed("pause_menu_1") or Input.is_action_just_pressed("pause_menu_2") or Input.is_action_just_pressed("pause_menu_3"):
		visible = not visible
		hud.visible = not visible
		
		if visible:
			# Pause the player when opening map.
			get_tree().paused = true
			# Update map offset when opening it.
			update_offset()
		else:
			get_tree().paused = false
	
	if visible:
		var move_offset: Vector2i
		if Input.is_action_just_pressed("ui_left"):
			move_offset = Vector2i.LEFT
		elif Input.is_action_just_pressed("ui_right"):
			move_offset = Vector2i.RIGHT
		elif Input.is_action_just_pressed("ui_up"):
			move_offset = Vector2i.UP
		elif Input.is_action_just_pressed("ui_down"):
			move_offset = Vector2i.DOWN
			
		# This moves the MapView's visible area, ensuring that only newly visible cells are redrawn.
		map_view.move(move_offset)
		# Player position node needs to be moved accordingly.
		player_location.offset = -Vector2(map_view.begin) * MetSys.CELL_SIZE
		# Update delta vector.
		offset += move_offset


# Assigns the initial offset when the map is opened. It centers on the player position.
func update_offset() -> void:
	offset = MetSys.get_current_flat_coords() - SIZE / 2
	# Player position node needs to be moved accordingly.
	player_location.offset = -Vector2(offset) * MetSys.CELL_SIZE
	# Updates map view initial position.
	map_view.move_to(Vector3i(offset.x, offset.y, MetSys.current_layer))
	# Update all cells of MapView to reflect the current state.
	map_view.update_all()
