class_name PlayerHUD
extends HBoxContainer

const PlayerColors = {
	"P1": Color.RED,
	"P2": Color.BLUE,
	"P3": Color.YELLOW,
	"P4": Color.GREEN
}

@export var missile_count: int:
	set(value):
		missile_count = value
		missile_label.text = pad_count_for_display(value)

@export var energy: int:
	set(value):
		energy = value
		energy_label.text = pad_count_for_display(energy % 100)
		redraw_energy_tanks(energy)
@export var player_index: int
@export var energy_tanks := 0
@export var missile_rockets := 0:
	set(value):
		missile_rockets = value
		if value > 0:
			show_missiles()


@onready var e_tank_scene := preload("res://src/ui/energy_tank.tscn") as PackedScene
@onready var e_tank_grid_container: GridContainer = %ETankGridContainer
@onready var e_tank_container: HBoxContainer = %ETankContainer
@onready var missile_container: HBoxContainer = %MissileContainer
@onready var energy_label: Label = %EnergyLabel
@onready var missile_label: Label = %MissileLabel
@onready var player_color_indicator: ColorRect = %PlayerColorIndicator
@onready var missile_bg: ColorRect = %MissileBG


func _ready() -> void:
	missile_label.text = str(missile_count)
	energy_label.text = str(energy)
	missile_rockets = missile_rockets
	#if missile_rockets == 0:
		#hide_missiles()
	#else:
		#show_missiles()
	match player_index:
		0:
			player_color_indicator.color = PlayerColors.P1
		1:
			player_color_indicator.color = PlayerColors.P2
		2:
			player_color_indicator.color = PlayerColors.P3
		3:
			player_color_indicator.color = PlayerColors.P4


func redraw_energy_tanks(amount: int) -> void:
	if energy_tanks == 0 :
		e_tank_container.hide()
		return
	
	e_tank_container.show()
	var old_tanks := e_tank_grid_container.get_children()
	for t in old_tanks:
		t.queue_free()
		
	var i := 0
	for tank in energy_tanks:
		var e := e_tank_scene.instantiate() as ColorRect
		if i * 100 > amount - 100 :
			e.color = Color.html('#734A52')
		e_tank_grid_container.add_child(e)
		i += 1


func pad_count_for_display(value: int) -> String:
	return "%0*d" % [2, value]
	
	
func hide_missiles() -> void:
	missile_container.hide()


func show_missiles() -> void:
	missile_container.show()
	
	
func update_energy(e: int) -> void:
	energy = e
	
	
func update_energy_tanks(et: int) -> void:
	energy_tanks = et
	# This forces a redraw for all players energy tanks.
	energy = energy
	
	
func update_missile_rockets(mr: int) -> void:
	missile_rockets = mr
	
	
func update_missile_count(mc: int) -> void:
	missile_count = mc
	
	
func update_missile_armed(armed: bool) -> void:
	if armed:
		missile_bg.color = Color.html('#4AAD39')
	else:
		missile_bg.color = Color.html('#734A52')
