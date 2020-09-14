extends Node2D

class_name BeamCannon

const BEAM := preload("res://Scenes/Beam.tscn")
const MISSILE := preload("res://Scenes/Missile.tscn")
#const SUPER_MISSILE := preload("res://Scenes/Beam.tscn")
const BEAM_COLOR := Color(1, 0, 0, 0.25)
const MISSILE_COLOR := Color(0, 0, 1, 0.25)

onready var barrel := $Barrel
onready var arrow := $Barrel/Arrow
onready var beam_state_machine := $BeamStateMachine
onready var fire_audio := $FireAudioStreamPlayer2D

var fire_direction := Vector2.RIGHT


func _ready() -> void:
	arrow.visible = OS.is_debug_build()


func _physics_process(delta) -> void:
	var barrel_direction = get_barrel_direction()
	if barrel_direction:
		fire_direction = barrel_direction

	arrow.rotation_degrees = rad2deg(fire_direction.angle())
	if OS.is_debug_build():
		if missile_is_armed():
			arrow.get_node("ColorRect").color = MISSILE_COLOR
			arrow.get_node("Polygon2D").color = MISSILE_COLOR
		else:
			arrow.get_node("ColorRect").color = BEAM_COLOR
			arrow.get_node("Polygon2D").color = BEAM_COLOR


func fire() -> void:
	var shot = BEAM.instance()
	if Input.is_action_pressed("arm"):
		shot = MISSILE.instance()
	shot.direction = fire_direction
	shot.position = global_position
	get_tree().get_root().add_child(shot)
	fire_audio.play()


func get_barrel_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()


func missile_is_armed() -> bool:
	return beam_state_machine.current_state == beam_state_machine.states_map["missile"]
