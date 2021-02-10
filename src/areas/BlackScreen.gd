extends ColorRect

signal fade_in_finished
signal fade_out_finished

var _black := Color(1, 1, 1, 1)
var _transparent := Color(1, 1, 1, 0)

onready var _tween := $Tween


func fade_in() -> void:
	_interpolate(_transparent, _black)
	yield(_tween, 'tween_completed')
	emit_signal("fade_in_finished")


func fade_out() -> void:
	_interpolate(_black, _transparent)
	yield(_tween, 'tween_completed')
	emit_signal("fade_out_finished")
	queue_free()


func _interpolate(old, new) -> void:
	var duration = 0.5

	_tween.stop_all()
	_tween.interpolate_property(self, "modulate", old, new, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
