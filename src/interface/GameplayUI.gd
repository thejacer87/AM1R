extends Control

onready var map_container := $MapContainer

func _ready() -> void:
	Globals.GameplayUI = self


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		if get_tree().paused:
			unpause()
		else:
			pause()
		get_tree().paused = not get_tree().paused


func pause() -> void:
	# Bring up pause menu. aka map
	map_container.show_map()
	pass


func unpause() -> void:
	map_container.hide_map()
	pass
