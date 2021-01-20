extends StaticBody2D

onready var wall := $Wall
onready var door := $Sprites/Door

func _on_transition_completed(samus) -> void:
	_lock()


func _unlock() -> void:
	wall.set_deferred("disabled", true)
	# Animate instead of hide
	door.hide()


func _lock() -> void:
	wall.set_deferred("disabled", false)
	# set timer and close the door instead
	door.show()


func _on_Lock_area_entered(shot):
	_unlock()
