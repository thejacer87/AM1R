class_name RoomTransitionControl
extends Control
@onready var fadeout_color_rect: ColorRect = %FadeoutColorRect

@export var player: Samus
@export var current_room: Room
@export var next_room: Room

var black := Color.BLACK
var transparent := Color(0,0,0,0)


func _ready() -> void:
	fadeout_color_rect.color = transparent
	EventBus.connect("room_transition_started", transition)


func transition(player: Samus, door: Door, next_door: Door) -> void:
	if player:
		var next_room := next_door.current_room
		var camera := player.camera
		var tween := create_tween().set_ease(Tween.EASE_OUT)
		print("before", Time.get_time_dict_from_system())
		# pause
		door.z_index = 50
		next_door.z_index = 50
		
		player.collision_layer = 0
		player.visible = false
		
		# move camera while closing door
		door.close_door()
		# TODO: tween left or right depending on direction? should be able to get it from scale.x
		tween.tween_property(camera, "limit_right", next_room.camera_bounds.right.global_position.x, 1)
		tween.parallel().tween_property(camera, "limit_left", next_room.camera_bounds.left.global_position.x, 1)
		await tween.finished
		player.bind_camera_limits(next_room)
		
		#open door
		next_door.open_door()
		##player.global_position = door.exit_marker.global_position
		var tween2 := create_tween()
		tween2.tween_property(player, "global_position", door.exit_marker.global_position, 1)
		player.visible = true
		await tween2.finished
		
		##close door
		next_door.close_door()
		door.z_index = 0
		next_door.z_index = 0
		## samus appears
		#print("after", Time.get_time_dict_from_system())
		player.collision_layer = Globals.COLLISION_PLAYER
		EventBus.emit_signal("room_transition_finished", next_room)
	
