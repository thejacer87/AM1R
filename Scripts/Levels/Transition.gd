extends Area2D


onready var left := $CameraLimits/Left
onready var right := $CameraLimits/Right
onready var top := $CameraLimits/Top
onready var bottom := $CameraLimits/Bottom
onready var exit := $Exit


#func _on_transition_completed() -> void:
#	pass


func _on_Transition_body_entered(samus: Node) -> void:
	var camera : MainCamera = samus.get_node("Camera2D")
#	camera.connect("transition_completed", self, "_on_transition_completed")
	camera.transition(samus, left, right, top, bottom, exit)
