extends ColorRect

var _black := Color(1, 1, 1, 1)
var _transparent := Color(1, 1, 1, 0)

onready var _tween := $Tween


func _interpolate(old, new) -> void:
	var duration := 0.125
	var trans := Tween.TRANS_LINEAR
	var easing := Tween.EASE_OUT

	_tween.stop_all()
	_tween.interpolate_property(self, "modulate", old, new, duration, trans, easing)
	_tween.start()


func fade_in() -> void:
	_interpolate(_transparent, _black)
	yield(_tween, 'tween_completed')

func fade_out() -> void:
	_interpolate(_black, _transparent)
	yield(_tween, 'tween_completed')
	queue_free()

