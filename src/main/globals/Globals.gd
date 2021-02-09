extends Node

const UNIT_SIZE := 16.0
const SCREEN_WIDTH := 512
const SCREEN_HEIGHT := 288
var STATES := {}

const BOMB := preload("res://src/weapons/Bomb.tscn")
const BEAM := preload("res://src/weapons/Beam.tscn")
const MISSILE := preload("res://src/weapons/Missile.tscn")

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
	'beam': "res://assets/audio/sfx/beam.wav",
	'missile': "res://assets/audio/sfx/missile.wav",
	'jump': "res://assets/audio/sfx/jump.wav"
}
