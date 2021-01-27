extends Node

const UNIT_SIZE := 16.0
const SCREEN_WIDTH := 512
const SCREEN_HEIGHT := 288
var STATES := {}

# Preloaded Scenes
const BOMB := preload("res://Scenes/Samus/Weapons/Bomb.tscn")
const BEAM = preload("res://Scenes/Samus/Weapons/Beam.tscn")
const MISSILE = preload("res://Scenes/Samus/Weapons/Missile.tscn")

var GameMusic
var GameSFX
var GameplayUI
var UI
var Samus

var bit_masks := {
	"samus": 1
}

var sfx := {
	'beam': "res://Sounds/beam.wav",
	'missile': "res://Sounds/missile.wav",
	'jump': "res://Sounds/jump.wav"
}
