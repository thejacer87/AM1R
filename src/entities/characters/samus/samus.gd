class_name Samus
extends CharacterBody2D

enum look_directions {LEFT = -1, RIGHT = 1}

const SPEED := 200.0
const JUMP_VELOCITY := -275.0


@export var energy := 99
@export var GRAVITY := 400.0
@export var player_index: int = 0

@onready var fsm := $StateMachine as StateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label

var looking := look_directions.RIGHT

func _process(_delta: float) -> void:
	label.text = fsm.state.name
	label.text += "\nLooking: " + str(looking)
	animated_sprite_2d.flip_h = looking == look_directions.LEFT
	
func damage(base_damage: int) -> void:
	energy -= base_damage
