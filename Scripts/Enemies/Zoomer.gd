extends Node2D


func damage() -> void:
	queue_free()


func _on_Hurtbox_area_entered(area):
	print('hit zoomer')
	damage()
