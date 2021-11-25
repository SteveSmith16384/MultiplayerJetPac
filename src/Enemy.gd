extends Sprite

const SPEED = 70

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(20, 300)
	pass


func _physics_process(delta):
	self.position.x -= SPEED * delta
	pass



func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		self.queue_free()
		body.die()
		pass
	else:
		self.queue_free()
		pass
	
	pass
