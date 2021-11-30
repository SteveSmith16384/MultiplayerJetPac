extends Sprite

const SPEED = 70

onready var main = get_tree().get_root().get_node("World")
var dir : int

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(20, 300)
	dir = 1
	if Globals.rnd.randi_range(0, 1) == 1:
		dir = -1;
		self.flip_h = true
	pass


func _physics_process(delta):
	self.position.x -= SPEED * delta * dir
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		body.die()

	main.show_explosion(self)
	main.enemy_destroyed()
	self.queue_free()
	pass
