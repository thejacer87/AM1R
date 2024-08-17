class_name Bomb
extends Area2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.queue("explode")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Samus:
		var samus := body as Samus
		if samus.state_machine.state.name == BaseMovement.MORPHING:
			samus.bombed()
