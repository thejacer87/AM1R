tool
extends Node2D

class_name BeamCannon

export var FIRE_DIRECTION := Vector2.RIGHT
onready var arrow := $Barrel/Arrow
onready var beam_state_machine := $BeamStateMachine


func _ready() -> void:
	if Engine.editor_hint:
		arrow.visible = true


func _physics_process(delta) -> void:
	arrow.rotation_degrees = rad2deg(FIRE_DIRECTION.angle())
	if missile_is_armed():
		arrow.get_node("ColorRect").color = Color.blue
		arrow.get_node("Polygon2D").color = Color.blue
	else:
		arrow.get_node("ColorRect").color = Color.red
		arrow.get_node("Polygon2D").color = Color.red


func missile_is_armed() -> bool:
	return beam_state_machine.current_state == beam_state_machine.states_map["missile"]
