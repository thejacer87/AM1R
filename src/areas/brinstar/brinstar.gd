class_name Brinstar
extends Node2D

@export var seed := 0x00000000


func _ready() -> void:
	build_brinstar()
	

func build_brinstar() -> void:
	var brinstar_resource := BrinstarResource.new()
	var rooms := brinstar_resource.build_rooms(seed)
	var previous_room: Room
	
	for room: Room in rooms:
		add_child(room)
		if previous_room:
			# connect doors
			var right_doors := previous_room.doors.filter(func(door: Door) -> bool: return door.direction == 'right')
			var door := room.doors[0]
			door.next_door = right_doors[0]
			right_doors[0].next_door = door
			room.global_position.x = right_doors[0].global_position.x - room.room_offset
		else:
			for door: Door in room.doors:
				door.enable_collisions()

		previous_room = room
	return
