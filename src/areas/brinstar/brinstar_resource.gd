class_name BrinstarResource
extends Resource

const ROOMS := 3

@export var version := 1
@export var reset_point : String



func build_rooms(seed: int) -> Array:
	var rooms := Array() 
	
	if seed == 0:
		var room1 := preload("res://src/areas/brinstar/b_1.tscn").instantiate() 
		var room2 := preload("res://src/areas/brinstar/b_2.tscn").instantiate() 
		var room3 := preload("res://src/areas/brinstar/b_3.tscn").instantiate() 
	
		rooms.append(room1)
		rooms.append(room2)
		rooms.append(room3)
	
	return rooms
