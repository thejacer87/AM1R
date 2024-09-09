extends Node

signal audio_finished


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	Globals.sfx = self


func play(path: String) -> void:
	var audio_file := load(path)
	var new_player := audio.duplicate() as AudioStreamPlayer
	new_player.finished.connect(_on_audio_finished.bind(new_player))
	#new_player.connect("finished", self, "_on_audio_finished", [new_player])
	get_tree().get_root().add_child(new_player)
	new_player.stream = audio_file
	new_player.play()


func _on_audio_finished(player: AudioStreamPlayer) -> void:
	player.queue_free()
