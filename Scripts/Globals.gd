extends Node

const UNIT_SIZE := 16.0
const SCREEN_WIDTH := 300
const SCREEN_HEIGHT := 180
var STATES := {}

# Preloaded Scenes
const BOMB := preload("res://Scenes/Samus/Weapons/Bomb.tscn")
const BEAM = preload("res://Scenes/Samus/Weapons/Beam.tscn")
const MISSILE = preload("res://Scenes/Samus/Weapons/Missile.tscn")

var GameMusic
var GameSFX
var Samus


var sfx := {
	'beam': "res://Sounds/beam.wav",
	'missile': "res://Sounds/missile.wav",
	'jump': "res://Sounds/jump.wav"
}
