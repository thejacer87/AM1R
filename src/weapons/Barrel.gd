tool
extends Position2D

export var direction := Vector2.RIGHT

onready var arrow := $Arrow


func _ready() -> void:
	if Engine.editor_hint:
		arrow.visible = true


func _process(delta):
	if Engine.editor_hint:
		arrow.rotation_degrees = rad2deg(direction.angle())
