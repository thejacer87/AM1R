extends Node

onready var audio := $AudioStreamPlayer


func _ready() -> void:
	Globals.GameMusic = self
	# todo just for testing
	audio.volume_db = -80


func update_volume(vol: int) -> void:
	audio.volume_db = vol


func play(path) -> void:
	var audio_file = load(path)
	audio.stop()
	audio.stream = audio_file
	audio.play()


func stop() -> void:
	audio.stop()
