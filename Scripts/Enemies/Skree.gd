class_name Skree
extends Enemy

const FLOOR := Vector2.UP
const GRAVITY := 980
const MAX_FALL_SPEED := 250

var _samus: Samus
var _velocity := Vector2.ZERO
var _attacking := false

onready var timer := $Timer
onready var raycast_left := $LeftRayCast2D
onready var raycast_right := $RightRayCast2D
onready var animated_player := $AnimationPlayer


func _ready() -> void:
	animated_player.play("idle")


func _physics_process(delta: float) -> void:
	if _attacking:
		_attack(delta)
	if raycast_left.is_colliding():
		_detect(raycast_left.get_collider())
	if raycast_right.is_colliding():
		_detect(raycast_right.get_collider())


func detected() -> void:
	_attacking = true


func _die(drop_item := true) -> void:
	timer.stop()
	animated_player.play("idle")
	animated_player.playback_speed = 1
	._die(drop_item)


func _apply_gravity(delta: float) -> void:
	if _velocity.y < MAX_FALL_SPEED:
		_velocity.y += GRAVITY * delta


func _detect(samus: Samus) -> void:
	_samus = samus
	animated_player.play("detected")


func _attack(delta: float) -> void:
	_apply_gravity(delta)
	animated_player.play("idle")
	move_and_slide(_velocity, FLOOR)
	global_position.x = lerp(global_position.x, _samus.global_position.x, 0.01)
	if is_on_floor():
		_attacking = false
		timer.start()
		_velocity = Vector2.ZERO
		_disable_raycasts()
		animated_player.playback_speed = 2


func _disable_raycasts() -> void:
	raycast_left.set_deferred("enabled", false)
	raycast_right.set_deferred("enabled", false)


func _enable_raycasts() -> void:
	raycast_left.set_deferred("enabled", true)
	raycast_right.set_deferred("enabled", true)


func _disable_collisions() -> void:
	_disable_raycasts()
	._disable_collisions()


func _enable_collisions() -> void:
	_enable_raycasts()
	._enable_collisions()


func _on_Timer_timeout() -> void:
	#explode
	_die(false)
