extends Node2D

const SPEED = 90
enum Type {Fireball, Fuzzy}

onready var main = get_tree().get_root().get_node("World")

var type
var x_dir : float
var y_dir : float

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(10, 300)#

	$Fireball.visible = false
	$Fuzzy.visible = false
		
	if Globals.enemy_type == 0:
		type = Type.Fireball
		$Fireball.visible = true
		x_dir = 1
		if Globals.rnd.randi_range(0, 1) == 1:
			x_dir = -1;
			$Rocket.flip_h = true
			$Fireball.flip_h = true
		y_dir = Globals.rnd.randf_range(-.5, .5)
	elif Globals.enemy_type == 1:
		type = Type.Fuzzy
		$Fuzzy.visible = true
		change_fuzzy_dir()
	pass


func change_fuzzy_dir():
	x_dir = 1
	y_dir = 1
	if Globals.rnd.randi_range(0, 1) == 1:
		x_dir = -1;
	if Globals.rnd.randi_range(0, 1) == 1:
		y_dir = -1;
	pass
	
	
func _physics_process(delta):
	self.position.x -= SPEED * delta * x_dir
	self.position.y -= SPEED * delta * y_dir
	
	if position.y < 20:
		self.position.y += 1
		y_dir = y_dir * -1
		pass
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		body.die()
		main.show_explosion(self)
		self.queue_free()
		return
	elif body.is_in_group("lasers"):
		main.show_explosion(self)
		self.queue_free()
		return
		
	if type == Type.Fuzzy:
		change_fuzzy_dir()
	else:
		main.show_explosion(self)
		main.enemy_destroyed()
		self.queue_free()
		pass
	pass
