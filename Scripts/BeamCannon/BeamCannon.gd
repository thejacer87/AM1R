tool
extends Node2D


class_name BeamCannon

export var FIRE_DIRECTION := Vector2.RIGHT
onready var arrow := $Barrel/Arrow


func _ready() -> void:
	if Engine.editor_hint:
		arrow.visible = true


func _physics_process(delta) -> void:
	arrow.rotation_degrees = rad2deg(FIRE_DIRECTION.angle())
