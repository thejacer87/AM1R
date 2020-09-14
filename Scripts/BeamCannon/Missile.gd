extends Area2D

const MISSILE_FULL_SPEED := 175
onready var missile_speed := 25
export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO


func _ready() -> void:
	rotation_degrees = rad2deg(direction.angle())


func _physics_process(delta) -> void:
	velocity.x = direction.x * missile_speed * delta
	velocity.y = direction.y * missile_speed * delta
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Hitbox_body_entered(body):
	# if not wave beam
	queue_free()


func _on_Hitbox_area_entered(area):
	queue_free()


func _on_Timer_timeout():
	missile_speed = MISSILE_FULL_SPEED
