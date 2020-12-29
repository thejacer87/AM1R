extends Node2D

class_name Weapon

const BEAM_COLOR := Color(1, 0, 0, 0.25)
const MISSILE_COLOR := Color(0, 0, 1, 0.25)
const MORPH_POSITION_OFFSET := 16

onready var barrel := $Barrel
onready var arrow := $Barrel/Arrow
onready var weapon_state_machine := $WeaponStateMachine
onready var samus := get_owner()

var fire_direction := Vector2.RIGHT


func _ready() -> void:
	arrow.visible = OS.is_debug_build()


func _physics_process(_delta) -> void:
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


func fire(weapon: Area2D, is_missile : bool = false) -> void:
	if is_missile:
		if has_missiles() and get_tree().get_nodes_in_group("MISSILES").size() == 0:
			weapon.direction = fire_direction
			weapon.position = global_position
			samus.missile_count -= 1
			get_tree().get_root().add_child(weapon)
	else:
		weapon.direction = fire_direction
		weapon.position = global_position
		get_tree().get_root().add_child(weapon)
		


func bomb(bomb: Area2D) -> void:
	if get_tree().get_nodes_in_group("BOMBS").size() < 3:
		bomb.direction = fire_direction
		bomb.position = owner.global_position
		bomb.position.y += MORPH_POSITION_OFFSET
		get_tree().get_root().add_child(bomb)


func get_barrel_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()


func missile_is_armed() -> bool:
	return weapon_state_machine.current_state == Globals.STATES["Weapon"].states_map["missile"]


func has_missiles() -> bool:
	var m = samus.missile_count
	return samus.missile_count > 0
