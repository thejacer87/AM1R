class_name BaseMovement
extends State

const IDLE = "Idle"
const MORPHING = "Morphing"
const CROUCHING = "Crouching"
const RUNNING = "Running"
const JUMPING = "Jumping"
const SPIN_JUMPING = "SpinJumping"
const FALLING = "Falling"
const SPIN_FALLING = "SpinFalling"

var samus: Samus

func _ready() -> void:
	await owner.ready
	samus = owner as Samus
	assert(samus != null, "The MovementState state type must be used only in the samus scene. It needs the owner to be a Samus node.")

		
func enter(previous_state_path: String, data := {}) -> void:
	print("Entering State: " + name)
	if Input.is_action_pressed("left_" + str(samus.player_index)):
		samus.looking = samus.look_directions.LEFT
	elif Input.is_action_pressed("right_" + str(samus.player_index)):
		samus.looking = samus.look_directions.RIGHT
		

func physics_update(delta: float) -> void:
	samus.velocity.y = min(samus.velocity.y + samus.GRAVITY * delta, samus.MAX_FALL_SPEED)
	if Input.is_action_pressed("left_" + str(samus.player_index)):
		samus.looking = samus.look_directions.LEFT
	if Input.is_action_pressed("right_" + str(samus.player_index)):
		samus.looking = samus.look_directions.RIGHT
		

func exit() -> void:
	print("Exiting State: " + name)
	
	
func handle_diagonal_aiming(state: String) -> void:
	if Input.is_action_pressed("down_" + str(samus.player_index)):
		samus.aiming_down = true
	if Input.is_action_pressed("up_" + str(samus.player_index)):
		samus.aiming_down = false
	var animation := state + "_aim_diag_" + ("down_" if samus.aiming_down else "up_") + samus.look_direction
	samus.is_aiming = true
	samus.animation_player.play(animation)
	
	
func update_collisions(collision_to_enable: String) -> void:
	var col := samus.get_node("Hurtbox/CollisionShape2D") as CollisionShape2D
	if collision_to_enable == "crouch":
		samus.crouching_collision_shape_2d.disabled = false
		samus.morph_ball_collision_shape_2d.disabled = true
		samus.standing_collision_shape_2d.disabled = true
		samus.spin_collision_shape_2d.disabled = true
		col.shape = samus.crouching_collision_shape_2d.shape
		col.position = samus.crouching_collision_shape_2d.position
	elif collision_to_enable == "spin":
		samus.spin_collision_shape_2d.disabled = false
		samus.morph_ball_collision_shape_2d.disabled = true
		samus.standing_collision_shape_2d.disabled = true
		samus.crouching_collision_shape_2d.disabled = true
		col.shape = samus.spin_collision_shape_2d.shape
		col.position = samus.spin_collision_shape_2d.position
	elif collision_to_enable == "morph":
		samus.morph_ball_collision_shape_2d.disabled = false
		samus.standing_collision_shape_2d.disabled = true
		samus.crouching_collision_shape_2d.disabled = true
		samus.spin_collision_shape_2d.disabled = true
		col.shape = samus.morph_ball_collision_shape_2d.shape
		col.position = samus.morph_ball_collision_shape_2d.position
	else:
		samus.standing_collision_shape_2d.disabled = false
		samus.morph_ball_collision_shape_2d.disabled = true
		samus.crouching_collision_shape_2d.disabled = true
		samus.spin_collision_shape_2d.disabled = true
		col.shape = samus.standing_collision_shape_2d.shape
		col.position = samus.standing_collision_shape_2d.position
