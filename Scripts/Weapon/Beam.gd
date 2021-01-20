extends Area2D

const SPEED := 450
export var direction := Vector2.RIGHT

var velocity := Vector2.ZERO
var beam_distance := 0.15
var long_beam_distance := 0.5

onready var timer := $Timer


func _ready() -> void:
	rotation_degrees = rad2deg(direction.angle())
	Globals.GameSFX.play(Globals.sfx['beam'])
	timer.wait_time = long_beam_distance if Globals.Samus.has_powerup("long_beam") else beam_distance
	timer.start()


func _physics_process(delta) -> void:
	velocity.x = direction.x * SPEED * delta
	velocity.y = direction.y * SPEED * delta
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	queue_free()


func _on_Hitbox_body_entered(body):
	# if not wave beam
	queue_free()


func _on_Hitbox_area_entered(area):
	queue_free()
