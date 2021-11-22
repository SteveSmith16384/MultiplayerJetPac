extends Node

const VERSION = "1.0"
const RELEASE_MODE = false

const NO_ENEMIES = false and !RELEASE_MODE
const PLAYER_INVINCIBLE = false and !RELEASE_MODE


enum ObjectType {Fuel, Ship1, Ship2, Ship3}

const START_LIVES = 9

# Other settings
var MUSIC_ON = true

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

