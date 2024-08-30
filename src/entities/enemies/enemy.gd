class_name Enemy
extends CharacterBody2D

@export var starting_hp := 10
@export var is_frozen := false
@export var can_freeze := true

var hp: int
var starting_pos: Vector2
var is_dead := false

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_spawner := preload("res://src/entities/items/pickups/pickup_spawner.tscn")
@onready var freeze_timer: Timer = $FreezeTimer


func _ready() -> void:
	hp = starting_hp
	starting_pos = position


func _physics_process(delta: float) -> void:
	_move(delta)
	

func _move(delta: float) -> void:
	pass


func _regenerate() -> void:
	hp = starting_hp
	is_dead = false
	_enable_collisions()
	_show_sprite()
	set_physics_process(true)


func damage(amount: int) -> void:
	if is_dead:
		return
	hp -= amount
	if (hp <= 0):
		_die()


func _die(drop_item := true) -> void:
	if drop_item:
		drop_item()
	set_physics_process(false)
	_disable_collisions()
	_hide_sprite()
	is_dead = true
	position = starting_pos


func drop_item() -> void:
	add_child(pickup_spawner.instantiate())


func freeze() -> void:
	is_frozen = true
	freeze_timer.start()
	_pause_animations()
	set_physics_process(false)
	_disable_hitboxes()
	set_collision_layer_value(3, true)
	modulate = Color.DARK_CYAN


func unfreeze() -> void:
	is_frozen = false
	_play_animations()
	set_physics_process(true)
	_enable_hitboxes()
	set_collision_layer_value(3, false)
	modulate = Color.WHITE
	
	
func _pause_animations() -> void:
	animated_sprite_2d.pause()
	
	
func _play_animations() -> void:
	animated_sprite_2d.play()
	
	
func _disable_collisions() -> void:
	_disable_hitboxes()
	collision_shape_2d.disabled = true


func _enable_collisions() -> void:
	_enable_hitboxes()
	collision_shape_2d.disabled = false
	
	
func _disable_hitboxes() -> void:
	hitbox.set_collision_layer_value(2, false)
	hurtbox.set_collision_layer_value(2, false)


func _enable_hitboxes() -> void:
	hitbox.set_collision_layer_value(2, true)
	hurtbox.set_collision_layer_value(2, true)


func _hide_sprite() -> void:
	animated_sprite_2d.visible = false


func _show_sprite() -> void:
	animated_sprite_2d.visible = true
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		var hitbox := area as Hitbox
		var parent := hitbox.get_parent()
		if parent is Beam:
			var beam := parent as Beam
			if beam.collectibles.power_item_enabled("ice_beam") and not is_frozen and can_freeze:
				freeze()
				return   
		damage(hitbox.damage)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	if is_dead:
		_regenerate()


func _on_freeze_timer_timeout() -> void:
	# If you kill it while frozen, then the timer goes off, this will start the
	# physics process again. This check handles that.
	if hp > 0:
		unfreeze()
