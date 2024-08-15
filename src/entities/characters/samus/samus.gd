class_name Samus
extends CharacterBody2D

enum look_directions {LEFT = -1, RIGHT = 1}

const SPEED := 115.0
const MAX_FALL_SPEED := 250.0
const WALL_JUMP_SPEED := 66.66667

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
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var crouch_run_timer: Timer = $CrouchRunTimer
@onready var aim_timer: Timer = $AimTimer
@onready var wall_jump_timer: Timer = $WallJumpTimer
@onready var idle_timer: Timer = $IdleTimer
@onready var arm_cannon: ArmCannon = $ArmCannon
@onready var is_aiming := false
@onready var aiming_down := false
@onready var look_direction := "right"


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
	label.text += "\nAim Timer: " + str(animation_player.current_animation)
	if looking == look_directions.LEFT:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
		
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire_" + str(player_index)):
		shoot()
	
	
func wall_jump(wall_direction: int) -> void:
	print("Samus.gd: wall jump")
	looking = -looking
	velocity.x = 1.75 * -wall_direction * WALL_JUMP_SPEED
	velocity.y = MAX_JUMP_VELOCITY * 0.8
	
	
func shoot() -> void:
	is_aiming = true
	aim_timer.start()
	idle_timer.stop()
	arm_cannon.shoot()
	
	
func damage(base_damage: int) -> void:
	energy -= base_damage


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "idle_left":
		animation_player.play("stand_left")

	if anim_name == "idle_right":
		animation_player.play("stand_right")
		
	idle_timer.start()


func _on_aim_timer_timeout() -> void:
	is_aiming = false
