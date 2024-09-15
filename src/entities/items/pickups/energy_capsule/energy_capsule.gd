class_name EnergyCapsule
extends Pickup


enum EnergySize { SMALL = 5, MEDIUM = 20, LARGE = 30}


@export var size : EnergySize = EnergySize.SMALL

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	var animation := "large" if size != EnergySize.SMALL else "small"
	animated_sprite_2d.animation = animation
