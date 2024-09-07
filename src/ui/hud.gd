class_name HUD
extends Control


@onready var player_hud_container: HBoxContainer = %PlayerHUDContainer
@onready var player_hud_scene := preload("res://src/ui/player_hud.tscn")


func add_player(player: Samus) -> void:
	var player_hud := player_hud_scene.instantiate() as PlayerHUD
	player_hud.name = 'PlayerHUD' + str(player.player_index)
	player_hud.player_index = player.player_index
	player_hud_container.add_child(player_hud)
	
	
func _on_energy_updated(player_index: int, e: int) -> void:
	var node_path := "%PlayerHUDContainer/PlayerHUD" + str(player_index)
	var player_hud: PlayerHUD = get_node(node_path)
	player_hud.update_energy(e)
	
	
func _on_missile_count_updated(player_index: int, mc: int) -> void:
	var node_path := "%PlayerHUDContainer/PlayerHUD" + str(player_index)
	var player_hud: PlayerHUD = get_node(node_path)
	player_hud.update_missile_count(mc)
	

func _on_missile_armed(player_index: int, armed: bool) -> void:
	var node_path := "%PlayerHUDContainer/PlayerHUD" + str(player_index)
	var player_hud: PlayerHUD = get_node(node_path)
	player_hud.update_missile_armed(armed)
	
	
func _on_missile_rockets_updated(mr: int) -> void:
	for child in player_hud_container.get_children():
		var player_hud := child as PlayerHUD
		player_hud.update_missile_rockets(mr)
	
	
func _on_energy_tanks_updated(et: int) -> void:
	for child in player_hud_container.get_children():
		var player_hud := child as PlayerHUD
		player_hud.update_energy_tanks(et)
