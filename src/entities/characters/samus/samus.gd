class_name Samus
extends CharacterBody2D

enum look_directions {LEFT = -1, RIGHT = 1}

const SPEED := 115.0
const MAX_FALL_SPEED := 250.0
const WALL_JUMP_SPEED := 66.667

@export var energy := 99
@export var GRAVITY : float
@export var MAX_JUMP_VELOCITY: float
@export var MIN_JUMP_VELOCITY: float
@export var player_index: int = 0

@onready var fsm := $StateMachine as StateMachine
@onready var label: Label = $Label
@onready var morph_ball_collision_shape_2d: CollisionShape2D = $MorphBallCollisionShape2D
@onready var standing_collision_shape_2d: CollisionShape2D = $StandingCollisionShape2D
@onready var crouching_collision_shape_2d: CollisionShape2D = $CrouchingCollisionShape2D
@onready var spin_collision_shape_2d: CollisionShape2D = $SpinCollisionShape2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var crouch_run_timer: Timer = $CrouchRunTimer
@onready var aim_timer: Timer = $AimTimer
@onready var idle_timer: Timer = $IdleTimer
@onready var wall_jump_timer: Timer = $WallJumpTimer
@onready var arm_cannon: ArmCannon = $ArmCannon
@onready var is_aiming := false
@onready var aiming_down := false
@onready var look_direction := "right":
	get:
		return "left" if looking == look_directions.LEFT else "right"
@onready var state_machine: StateMachine = $StateMachine
@onready var bomb_scene := preload("res://src/entities/weapons/bombs/bomb.tscn")
@onready var bomb_drop_marker: Marker2D = $BombDropMarker
@onready var is_missile_armed := false
@onready var wall_check_top: RayCast2D = %WallCheckTop
@onready var wall_check_bottom: RayCast2D = %WallCheckBottom


var looking := look_directions.RIGHT
var jump_duration := 0.70
var max_jump_height : float = 10.5 * Globals.UNIT_SIZE
var min_jump_height : float = 4 * Globals.UNIT_SIZE


func _ready() -> void:
	GRAVITY = 2 * max_jump_height / pow(jump_duration, 2)
	MAX_JUMP_VELOCITY = -sqrt(2 * GRAVITY * max_jump_height) # for highjump* 1.4
	MIN_JUMP_VELOCITY = -sqrt(2 * GRAVITY * min_jump_height)


func _process(_delta: float) -> void:
	label.text = fsm.state.name
	label.text += "\nLooking: " + str(looking)
	label.text += "\nAim Timer: " + str(aim_timer.time_left)
	label.text += "\nWall Jump Timer: " + str(wall_jump_timer.time_left)
	label.text += "\nAnimation: " + str(animation_player.current_animation)
	label.text += "\nMissile: " + str("Armed" if is_missile_armed else "Nope")
	if looking == look_directions.LEFT:
		sprite_2d.flip_h = true
		wall_check_top.scale = Vector2(-1, -1)
		wall_check_bottom.scale = Vector2(-1, -1)
	else:
		sprite_2d.flip_h = false
		wall_check_top.scale = Vector2(1, 1)
		wall_check_bottom.scale = Vector2(1, 1)
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("arm_weapon_" + str(player_index)):
		is_missile_armed = true
			
	if Input.is_action_just_released("arm_weapon_" + str(player_index)):
		is_missile_armed = false

	if Input.is_action_just_pressed("fire_" + str(player_index)):
		print("current state: " + str(state_machine.state.name))
		if str(state_machine.state.name) == BaseMovement.MORPHING:
			drop_bomb()
		else:
			shoot()
	
	
func wall_jump(wall_direction: int) -> void:
	wall_jump_timer.stop()
	looking = -wall_direction
	velocity.x = 1.75 * -wall_direction * WALL_JUMP_SPEED
	velocity.y = MAX_JUMP_VELOCITY * 0.85
	
	
func shoot() -> void:
	is_aiming = true
	aim_timer.start()
	idle_timer.stop()
	arm_cannon.shoot()
	
	
func damage(base_damage: int) -> void:
	energy -= base_damage


func drop_bomb() -> void:
	print("drop_bomb")
	var bomb := bomb_scene.instantiate() as Bomb
	bomb.global_position = bomb_drop_marker.global_position
	get_tree().get_root().add_child(bomb)
	

func bombed() -> void:
	velocity.y = -190


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "idle_left":
		animation_player.play("stand_left")

	if anim_name == "idle_right":
		animation_player.play("stand_right")
		
	idle_timer.start()


func _on_aim_timer_timeout() -> void:
	is_aiming = false
	
	
