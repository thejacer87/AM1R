class_name Beam
extends Area2D

@export var direction: Vector2
@export var power_ups: PowerUps 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flash_sprite_2d: Sprite2D = $FlashSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer
@onready var hitbox: Hitbox = $Hitbox

var beam_distance := 0.35
var long_beam_distance := 1.5

func _ready() -> void:
	audio_stream_player.play()
	timer.wait_time = long_beam_distance if power_ups.beams.long_beam.collected else beam_distance
	timer.start()


func _physics_process(delta: float) -> void:
	position.x += 300 * delta * direction.x
	position.y += 300 * delta * direction.y


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if not power_ups.beams.wave_beam.enabled:
#		Keep alive to finish audio? use global SFX player instead?
		queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()
