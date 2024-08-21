class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "user://save.tres"

@export var version := 1

@export var power_ups: PowerUps = PowerUps.new()


func write_save_game() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)
	
	
static func load_save_game() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
