extends Node

const UNIT_SIZE := 16.0
const SCREEN_WIDTH := 512
const SCREEN_HEIGHT := 288
var STATES := {}

const BOMB := preload("res://src/samus/weapons/Bomb.tscn")
const BEAM := preload("res://src/samus/weapons/Beam.tscn")
const MISSILE := preload("res://src/samus/weapons/Missile.tscn")

var GameMusic
var GameSFX
var GameState
var GameplayUI
var UI
var Samus

var _loader
var _main_scene
var _time_max := 100

var bit_masks := {
	"samus": 1
}

var sfx := {
	'beam': "res://Sounds/beam.wav",
	'missile': "res://Sounds/missile.wav",
	'jump': "res://Sounds/jump.wav"
}

var levels = {
		"Brinstar": "res://Scenes/Levels/Brinstar/Brinstar.tscn",
		"Kraid's Lair": "res://Scenes/Levels/KraidsLair/KraidsLair.tscn",
		"Norfair": "",
		"Ridley's Hideout": "",
		"Tourian": "",
	}

var levels_flip = {
		"res://Scenes/Levels/Brinstar/Brinstar.tscn": "Brinstar",
		"res://Scenes/Levels/KraidsLair/KraidsLair.tscn": "Kraid's Lair",
		"res://Scenes/Levels/Norfair/Norfair.tscn": "Norfair",
		"res://Scenes/Levels/RidleysHideout/RidleysHideout.tscn": "Ridley's Hideout",
		"res://Scenes/Levels/Tourian/Tourian.tscn": "Tourian",
	}
