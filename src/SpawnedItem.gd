extends KinematicBody2D

var type

func _ready():
	pass
	

func _physics_process(delta):
	var motion = Vector2(0, 5000*delta)
	self.move_and_slide(motion)
	pass
	


func _on_CollectArea2D_body_entered(body):
	if body.is_in_group("players"):
		body.carry_item(type)
		self.queue_free()
		pass
	pass
