extends Area2D

const SPEED := 250
export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO


func _ready() -> void:
	rotation_degrees = rad2deg(direction.angle())


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
