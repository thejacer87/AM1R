class_name Door
extends StaticBody2D

signal door_locked
signal door_unlocked

@export var next_door: Door
@export var door_lock: String = "blue"
@export var direction: String = "right"

@onready var door_animated_sprite_2d: AnimatedSprite2D = $DoorAnimatedSprite2D
@onready var exit_marker: Marker2D = %ExitMarker
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var gate: Area2D = $Gate

func _ready() -> void:
	door_animated_sprite_2d.play(door_lock)


func _process(delta: float) -> void:
	var shape : CollisionShape2D = $RoomExit/CollisionShape2D


func _on_gate_area_entered(area: Area2D) -> void:
	open_door()


func open_door() -> void:
	if not door_animated_sprite_2d.is_playing():
		door_animated_sprite_2d.play("open")
		await door_animated_sprite_2d.animation_finished
	collision_layer = 0
	collision_mask = 0
	gate.collision_layer = 0
	gate.collision_mask = 0
	door_unlocked.emit()


func close_door() -> void:
	door_animated_sprite_2d.play("close")
	await door_animated_sprite_2d.animation_finished
	door_animated_sprite_2d.play("blue")
	collision_layer = Globals.COLLISION_TERRAIN
	collision_mask = 0
	gate.collision_layer = Globals.COLLISION_DOOR_LOCK
	gate.collision_mask = Globals.COLLISION_BOMB + Globals.COLLISION_BEAM + Globals.COLLISION_MISSILE
	door_locked.emit()
