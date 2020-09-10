extends Node2D

class_name BeamCannon

const MISSILE_COLOR := Color(0, 0, 1, 0.25)
const BEAM_COLOR := Color(1, 0, 0, 0.25)

export var fire_direction := Vector2.RIGHT
onready var barrel := $Barrel
onready var arrow := $Barrel/Arrow
onready var beam_state_machine := $BeamStateMachine


func _ready() -> void:
	arrow.visible = OS.is_debug_build()


func _physics_process(delta) -> void:
	arrow.rotation_degrees = rad2deg(fire_direction.angle())
	if OS.is_debug_build():
		if missile_is_armed():
			arrow.get_node("ColorRect").color = MISSILE_COLOR
			arrow.get_node("Polygon2D").color = MISSILE_COLOR
		else:
			arrow.get_node("ColorRect").color = BEAM_COLOR
			arrow.get_node("Polygon2D").color = BEAM_COLOR


func get_barrel_direction() -> Vector2:
	return fire_direction

func missile_is_armed() -> bool:
	return beam_state_machine.current_state == beam_state_machine.states_map["missile"]
