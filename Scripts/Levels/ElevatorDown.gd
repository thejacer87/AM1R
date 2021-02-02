class_name Elevator
extends Node2D

var can_activate := false

var _samus
var _going_down := false

onready var platform_body := $StaticBody2D
onready var _tween := $Tween

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if _going_down:
		platform_body.position.y = lerp(platform_body.position.y, platform_body.position.y + 10, .1)


func _input(event: InputEvent) -> void:
	if can_activate and event.is_action_pressed("down"):
		_go_down_elevator()
		print("go down")


func _go_down_elevator() -> void:
	get_tree().get_root().set_disable_input(true)
	var from = _samus.global_position.x
	var to = global_position.x
	_tween.stop_all()
	_tween.interpolate_property(_samus, "global_position:x",
			from, to, .5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, 'tween_completed')
	_going_down = true


func _on_Area2D_body_entered(body: Node) -> void:
	can_activate = true
	_samus = body


func _on_Area2D_body_exited(body: Node) -> void:
	can_activate = false
