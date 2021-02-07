class_name Elevator
extends Node2D

export(String, FILE, "*tscn") var next_area
export(String) var next_room

var can_activate := false

var _samus

onready var animation_player := $AnimationPlayer setget ,get_animation_player


func _input(event: InputEvent) -> void:
	if can_activate and _samus.is_on_floor():
		if event.is_action_pressed("up"):
			AreaTransition.transition_out(animation_player, "up", next_area)
		if event.is_action_pressed("down"):
			AreaTransition.transition_out(animation_player, "down", next_area)


func get_animation_player() -> AnimationPlayer:
	return (animation_player as AnimationPlayer)


func _on_ActivationArea_body_entered(body: Node) -> void:
	can_activate = true
	_samus = body


func _on_ActivationArea_body_exited(body: Node) -> void:
	can_activate = false

