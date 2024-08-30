class_name Skree
extends Enemy


const FLOOR := Vector2.UP
const GRAVITY := 980
const MAX_FALL_SPEED := 400

var _samus: Samus
var _attacking := false

@onready var timer: Timer = $Timer
@onready var raycast_left: RayCast2D = $LeftRayCast2D
@onready var raycast_right: RayCast2D = $RightRayCast2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label


func _process(delta: float) -> void:
	label.text = "HP: " + str(hp)
	
	
func _physics_process(delta: float) -> void:
	if is_dead:
		hide_sprite()
	if _attacking:
		_attack(delta)
	if raycast_left.is_colliding():
		_detect(raycast_left.get_collider() as Samus)
	if raycast_right.is_colliding():
		_detect(raycast_right.get_collider() as Samus)


func _die(drop_item := true) -> void:
	timer.stop()
	_attacking = false
	animation_player.play("idle")
	animation_player.speed_scale = 1
	if drop_item:
		super.drop_item()
	set_physics_process(false)
	_disable_collisions()
	hide_sprite()
	is_dead = true
	position = starting_pos
	hide_sprite()


func _apply_gravity(delta: float) -> void:
	if velocity.y < MAX_FALL_SPEED:
		velocity.y += GRAVITY * delta


func _detect(samus: Samus) -> void:
	print("detected")
	_samus = samus
	animation_player.play("detected")


func _attack(delta: float) -> void:
	_apply_gravity(delta)
	animation_player.play("idle")
	move_and_slide()
	global_position.x = lerp(global_position.x, _samus.global_position.x, 0.05)
	if is_on_floor():
		_attacking = false
		timer.start()
		velocity = Vector2.ZERO
		_disable_raycasts()
		animation_player.speed_scale = 2


func detected() -> void:
	_attacking = true


func _disable_raycasts() -> void:
	raycast_left.enabled = false
	raycast_right.enabled = false


func _enable_raycasts() -> void:
	raycast_left.enabled = true
	raycast_right.enabled = true


func _pause_animations() -> void:
	print("skree pause")


func _play_animations() -> void:
	print("skree play")
	

func hide_sprite() -> void:
	animation_player.pause()
	animation_player.stop()
	sprite_2d.visible = false


func _show_sprite() -> void:
	sprite_2d.visible = true
	

func _disable_collisions() -> void:
	_disable_raycasts()
	super._disable_collisions()


func _enable_collisions() -> void:
	_enable_raycasts()
	super._enable_collisions()


func _regenerate() -> void:
	hp = starting_hp
	is_dead = false
	_enable_collisions()
	animation_player.play("idle")
	set_physics_process(true)
	

func _on_timer_timeout() -> void:
	print("explode")
	_die(false)
