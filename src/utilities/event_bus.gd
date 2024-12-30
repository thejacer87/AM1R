extends Node

signal room_transition_started(player: Samus, current_door: Door, next_door: Door)
signal room_transition_finished(player: Samus, room: Room)

func _ready() -> void:
	print("Event Bus Ready")


func _process(delta: float) -> void:
	pass
