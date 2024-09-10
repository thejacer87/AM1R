extends Node

signal audio_finished


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var sfx := {
	'beam': "res://src/audio/sfx/beam.wav",
	'missile': "res://src/audio/sfx/missile.wav",
	'jump': "res://src/audio/sfx/jump.wav",
	'bomb_drop': "res://src/audio/sfx/bomb_drop.wav",
	'bomb_explode': "res://src/audio/sfx/bomb_explode.wav"
}

func _ready() -> void:
	Globals.SFXPlayer = self


func play(path: String) -> void:
	var audio_file := load(path)
	var new_player := audio.duplicate() as AudioStreamPlayer
	new_player.finished.connect(_on_audio_finished.bind(new_player))
	get_tree().get_root().add_child(new_player)
	new_player.stream = audio_file
	new_player.play()


func _on_audio_finished(player: AudioStreamPlayer) -> void:
	player.queue_free()
