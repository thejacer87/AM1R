extends Area2D


onready var left := $CameraLimits/Left
onready var right := $CameraLimits/Right
onready var top := $CameraLimits/Top
onready var bottom := $CameraLimits/Bottom
onready var exit := $Exit

func _ready():
	pass 


func _on_Transition_body_entered(samus: Node) -> void:
	get_tree().paused = true
	var camera = samus.get_node('Camera2D')
	samus.position.x = exit.global_position.x
#	var tween = Tween.new()
#	tween.interpolate_property(camera, "position", camera.position, left.global_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	tween.start()
	yield(get_tree().create_timer(.7), "timeout")
	camera.limit_left = left.global_position.x
	camera.limit_right = right.global_position.x
	camera.limit_top = top.global_position.y
	camera.limit_bottom = bottom.global_position.y
	get_tree().paused = false
