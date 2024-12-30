extends Node

signal room_transition_started(player: Samus, door: Door, next_door: Door)
signal room_transition_finished(room: Room)

func _ready() -> void:
	print("Event Bus Ready")


func _process(delta: float) -> void:
	pass
