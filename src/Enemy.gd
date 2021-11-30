extends Node2D

const SPEED = 90

onready var main = get_tree().get_root().get_node("World")

var x_dir : int
var y_dir : float

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(10, 300)
	x_dir = 1
	if Globals.rnd.randi_range(0, 1) == 1:
		x_dir = -1;
		$Rocket.flip_h = true
		$Fireball.flip_h = true
	y_dir = Globals.rnd.randf_range(-1, 1)
	pass


func _physics_process(delta):
	self.position.x -= SPEED * delta * x_dir
	self.position.y -= (SPEED/4) * delta * y_dir
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		body.die()

	main.show_explosion(self)
	main.enemy_destroyed()
	self.queue_free()
	pass
