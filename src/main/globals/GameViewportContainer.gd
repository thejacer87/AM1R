extends ViewportContainer

onready var viewport := $Viewport

func _ready() -> void:
	Globals.GameViewport = viewport
