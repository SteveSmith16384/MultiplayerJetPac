extends Sprite

const SPEED = 50

#var dir = Vector2(-1, 0)

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(20, 300)
	pass


func _physics_process(delta):
	self.position.x -= SPEED * delta
	pass



func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		pass
	else: #if body.is_in_group("lasers"):
		self.queue_free()
		pass
	
	pass # Replace with function body.
