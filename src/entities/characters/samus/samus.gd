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
@onready var wall_stick_timer: Timer = $WallStickTimer


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
	label.text += "\nWall Jump timer: " + str(wall_stick_timer.time_left)
	sprite_2d.flip_h = looking == look_directions.LEFT
	
	
func damage(base_damage: int) -> void:
	energy -= base_damage
