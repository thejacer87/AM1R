extends Node

signal audio_finished

onready var audio := $AudioStreamPlayer


func _ready() -> void:
	Globals.GameSFX = self


func play(path) -> void:
	var audio_file = load(path)
	var new_player = audio.duplicate()
	new_player.connect("finished", self, "_on_audio_finished", [new_player])
	Globals.GameViewport.add_child(new_player)
	new_player.stream = audio_file
	new_player.play()


func _on_audio_finished(player: AudioStreamPlayer) -> void:
	emit_signal("audio_finished")
	player.queue_free()
