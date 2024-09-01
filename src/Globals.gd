extends Node

const VERSION = "1.3"
const RELEASE_MODE = false

const NO_ENEMIES = false and !RELEASE_MODE

enum ObjectType {Fuel, Ship1, Ship2, Ship3}

const PTS_FOR_DIAMOND = 150
const PTS_FOR_SHOOTING_ENEMY = 10
const PTS_FOR_COLLECTING_SHIP = 50
const PTS_FOR_DROPPING_SHIP = 50

# Other settings
var MUSIC_ON = true

var player_nums = []
var rnd : RandomNumberGenerator
var enemy_type : int

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

