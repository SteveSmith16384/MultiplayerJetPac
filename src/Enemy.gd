extends Sprite

const SPEED = 70

onready var main = get_tree().get_root().get_node("World")

func _ready():
	self.position.x = 512
	self.position.y = Globals.rnd.randi_range(20, 300)
	pass


func _physics_process(delta):
	self.position.x -= SPEED * delta
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		body.die()

	main.show_explosion(self)
	self.queue_free()
	pass
