class_name Room
extends Node2D


@export var grid_size := Vector2.ONE
@export var room_offset := 0
@export var doors : Array[Door] = []:
	get:
		var carry: Array[Door] = []
		for child in self.find_children("*"):
			if child.is_in_group("door"):
				carry.append(child)
		return carry

@onready var camera_bounds :=  {
			"top": $CameraBounds/Top,
			"bottom": $CameraBounds/Bottom,
			"left": $CameraBounds/Left,
			"right": $CameraBounds/Right
		}


func _ready() -> void:
	EventBus.connect("room_transition_finished", enable_exits)

func enable_exits(player: Samus, room: Room) -> void:
	if room == self:
		get_tree().paused = false
		player.collision_layer = Globals.COLLISION_PLAYER
