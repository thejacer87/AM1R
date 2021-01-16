extends Area2D


onready var left := $CameraLimits/Left
onready var right := $CameraLimits/Right
onready var top := $CameraLimits/Top
onready var bottom := $CameraLimits/Bottom
onready var exit := $Exit

func _on_transition_completed(samus) -> void:
	samus.hide_black_screen()


func _on_Transition_body_entered(samus: Samus) -> void:
	var camera = samus.get_node("Camera2D")
	camera.connect("transition_completed", self, "_on_transition_completed")
	var door = get_parent()
	camera.connect("transition_completed", door, "_on_transition_completed")
	samus.show_black_screen()
	camera.transition(samus, left, right, top, bottom, exit)
