class_name BaseMovement
extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"

var samus: Samus
var look_direction : String


func _ready() -> void:
	await owner.ready
	samus = owner as Samus
	assert(samus != null, "The MovementState state type must be used only in the samus scene. It needs the owner to be a Samus node.")

		
func enter(previous_state_path: String, data := {}) -> void:
	if data.has("look_direction"):
		look_direction = data.look_direction
	elif Input.is_action_pressed("left_" + str(samus.player_index)):
		samus.looking = samus.look_directions.LEFT
		look_direction = "left"
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		samus.looking = samus.look_directions.RIGHT
		look_direction = "right"
		

func physics_update(delta: float) -> void:
	if Input.is_action_pressed("left_" + str(samus.player_index)):
		samus.looking = samus.look_directions.LEFT
		look_direction = "left"
	if Input.is_action_pressed("right_" + str(samus.player_index)):
		samus.looking = samus.look_directions.RIGHT
		look_direction = "right"
