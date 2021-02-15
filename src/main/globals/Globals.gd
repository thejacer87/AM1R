extends Node

const UNIT_SIZE := 16.0
const SCREEN_WIDTH := 512
const SCREEN_HEIGHT := 288
const BOMB := preload("res://src/weapons/Bomb.tscn")
const BEAM := preload("res://src/weapons/Beam.tscn")
const MISSILE := preload("res://src/weapons/Missile.tscn")

enum Directions { UP = -1, DOWN = 1, LEFT = -1, RIGHT = 1 }

var STATES := {}
var Samus
var UI
var GameplayUI
var GameState
var GameMusic
var GameSFX
var bit_masks := { "samus": 1 }
var sfx := {
	'beam': "res://assets/audio/sfx/beam.wav",
	'missile': "res://assets/audio/sfx/missile.wav",
	'jump': "res://assets/audio/sfx/jump.wav"
}

var _loader
var _main_scene
var _time_max := 100

