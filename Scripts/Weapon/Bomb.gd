extends Area2D

const SPEED := 1
export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
onready var explosion_shape := $ExplosionHitbox/CollisionShape2D
onready var explosion := $ExplosionHitbox
onready var animation_player := $AnimationPlayer


func _ready() -> void:
	rotation_degrees = rad2deg(direction.angle())


func _physics_process(delta) -> void:
	# prolly change to rigid body
	velocity.y = SPEED
	translate(velocity) 


func _on_Timer_timeout():
	# play explosion animation
#	explosion_shape.set_deferred("disabled", false)
	explosion.set_deferred("monitored", true)
	explosion.set_deferred("monitorable", true)
	animation_player.play("Detonate")
	print('exploded')
	yield(get_tree().create_timer(2), "timeout")
	print('see ya')
	queue_free()


func _on_Hitbox_area_entered(area):
	print('bombed ' + area.name)
