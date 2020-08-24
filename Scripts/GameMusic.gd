extends Node2D

onready var audiostream := $Audio

func _ready() -> void:
#	Globals.GameMusic = self
	pass

func play(path) -> void:
	pass
	var audio_file = load(path)
	audiostream.stop()
	audiostream.stream = audio_file
	audiostream.play()

func stop() -> void:
	audiostream.stop()
