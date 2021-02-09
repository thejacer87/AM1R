extends Node2D

onready var timer := $Timer
onready var terrain := $Terrain
onready var terrain_collision := $Terrain/CollisionShape2D
onready var hurtbox := $Hurtbox/CollisionShape2D
onready var sprite := $Sprite

var restore_counter := 0


func _destroy():
	timer.start()
	sprite.hide()
	terrain_collision.set_deferred("disabled", true)
	hurtbox.set_deferred("disabled", true)


func _restore():
	if (restore_counter == 0):
		sprite.show()
		terrain_collision.set_deferred("disabled", false)
		hurtbox.set_deferred("disabled", false)
	else:
		yield(get_tree().create_timer(.5), "timeout")
		_restore()


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	_destroy()


func _on_Timer_timeout() -> void:
	_restore()


func _on_Restore_body_entered(body: Node) -> void:
	restore_counter += 1


func _on_Restore_body_exited(body: Node) -> void:
	restore_counter -= 1
