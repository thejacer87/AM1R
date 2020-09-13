extends Area2D

const SPEED := 250
export var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
onready var animation_tree := $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	pass


func _physics_process(delta) -> void:
	animation_state.travel("Beam")
	animation_tree.set("parameters/Beam/blend_position", direction)
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
