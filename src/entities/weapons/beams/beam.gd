class_name Beam
extends Area2D

@export var direction: Vector2
@export var collectibles: Collectibles 


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var hitbox: Hitbox = $Hitbox


var beam_distance: float:
	get:
		return 1.5 if has_long_beam else 0.35
var has_long_beam: bool:
	get:
		return collectibles.has_collected_power_item("long_beam")
var animation: String:
	get:
		return "wave_beam" if collectibles.has_collected_power_item("wave_beam") else "power_beam"
var time := 0.0

func _ready() -> void:
	if collectibles.has_collected_power_item("wave_beam"):
		hitbox.damage *= 2
	audio_stream_player.play()
	animation_player.play(animation)
	timer.wait_time = beam_distance
	timer.start()


func _physics_process(delta: float) -> void:
	var wave_offset := get_wave_offset(delta)
	position.x += 300 * delta * direction.x + (wave_offset * .2)
	position.y += 300 * delta * direction.y - (wave_offset * 3)


func get_wave_offset(delta: float) -> float:
	if not collectibles.has_collected_power_item("wave_beam"):
		return 0
	time += delta
	var f := 25
	var a := 1.5
	return cos(time * f) * a
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("hitbox body")
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("hitbox area")
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	print(" area")
	if not collectibles.power_items.wave_beam.enabled:
#		Keep alive to finish audio? use global SFX player instead?
		print("no wave beam")
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("body")
	if not collectibles.power_items.wave_beam.enabled:
#		Keep alive to finish audio? use global SFX player instead?
		print("no wave beam")
		queue_free()
