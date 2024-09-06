class_name HUD
extends Control

@export var missile_count: int:
	set(value):
		missile_count = value
		missile_label.text = pad_count_for_display(value)

@export var energy: int:
	set(value):
		energy = value
		energy_label.text = pad_count_for_display(energy % 100)
		redraw_energy_tanks(energy)
	
@export var energy_tanks := 0
@export var missile_rockets := 0

@onready var energy_label: Label = %EnergyLabel
@onready var missile_label: Label = %MissileLabel
@onready var e_tank_scene := load("res://src/ui/energy_tank.tscn") as PackedScene
@onready var e_tank_grid_container: GridContainer = %ETankGridContainer
@onready var missile_container: HBoxContainer = $HBoxContainer/MissileContainer
@onready var p1_missile_bg: ColorRect = %P1MissileBG
@onready var p2_missile_bg: ColorRect = %P2MissileBG

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	missile_label.text = str(missile_count)
	energy_label.text = str(energy)


func redraw_energy_tanks(amount: int) -> void:
	var old_tanks := e_tank_grid_container.get_children()
	for t in old_tanks:
		t.queue_free()
		
	var i := 0
	for tank in energy_tanks:
		var e := e_tank_scene.instantiate() as ColorRect
		if i * 100 > amount - 100 :
			e.color = Color.GRAY
		e_tank_grid_container.add_child(e)
		i += 1


func pad_count_for_display(value: int) -> String:
	return "%0*d" % [2, value]
	
	
func hide_missiles() -> void:
	missile_container.hide()


func show_missiles() -> void:
	missile_container.show()
	
	
func _on_energy_tanks_updated(et: int) -> void:
	energy_tanks = et
	

func _on_energy_updated(e: int) -> void:
	energy = e
	
	
func _on_missile_count_updated(c: int) -> void:
	missile_count = c
	

func _on_missile_armed(player_index: int, value: bool) -> void:
	match player_index:
		0:
			if value:
				p1_missile_bg.color = Color.GREEN
			else:
				p1_missile_bg.color = Color.BLACK
		1:
			if value:
				p2_missile_bg.color = Color.GREEN
			else:
				p2_missile_bg.color = Color.BLACK
	print("Player: " + str(player_index))
	print("Value: " + str(value))
	pass
