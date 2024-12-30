extends Node

const UNIT_SIZE = 16

# Collision Layers
const COLLISION_PLAYER = 1
const COLLISION_ENEMY = 2
const COLLISION_TERRAIN = 4
const COLLISION_DOOR_LOCK = 8
const COLLISION_ITEM = 16
const COLLISION_BEAM = 32
const COLLISION_MISSILE = 64
const COLLISION_BOMB = 128


var MusicPlayer: MusicPlayer
var SFXPlayer: SFXPlayer
