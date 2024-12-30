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


func transition(player: Samus, current_door: Door, next_door: Door) -> void:
	if player:
		player.collision_layer = 0
		var next_room := next_door.current_room
		var camera := player.camera
		
		# redraw appropriate sprites
		current_door.z_index = 50
		next_door.z_index = 50
		player.visible = false
		
		# move camera while closing door
		current_door.close_door()
		current_door.disable_collisions()
		
		# TODO: tween left or right depending on direction? should be able to get it from scale.x
		var tween := create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(camera, "limit_right", next_room.camera_bounds.right.global_position.x, 1)
		tween.parallel().tween_property(camera, "limit_left", next_room.camera_bounds.left.global_position.x, 1)
		await tween.finished
		player.bind_camera_limits(next_room)
		
		#open door and slide samus into play
		next_door.open_door()
		var tween2 := create_tween()
		player.global_position.x = player.global_position.x + (Globals.UNIT_SIZE * -next_door.scale.x)
		tween2.tween_property(player, "global_position", current_door.exit_marker.global_position, 1)
		player.visible = true
		await tween2.finished
		
		##close door
		next_door.close_door()
		current_door.z_index = 0
		next_door.z_index = 0
		
		EventBus.emit_signal("room_transition_finished", player, next_room)
	
