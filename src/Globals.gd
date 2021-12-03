extends Node

const VERSION = "1.0"
const RELEASE_MODE = true

const NO_ENEMIES = false and !RELEASE_MODE

enum ObjectType {Fuel, Ship1, Ship2, Ship3}

# Other settings
var MUSIC_ON = true

var player_nums = []
var rnd : RandomNumberGenerator
var enemy_type : int

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

