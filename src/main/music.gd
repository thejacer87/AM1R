extends Node

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	Globals.MusicPlayer = self


func update_volume(vol: int) -> void:
	audio.volume_db = vol


func play(path: String) -> void:
	var audio_file := load(path)
	audio.stop()
	audio.stream = audio_file
	audio.play()


func stop() -> void:
	audio.stop()
