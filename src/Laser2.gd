extends KinematicBody2D

const SPEED = 500

var dir = Vector2(1, 0)

func _ready():
	pass


func _physics_process(delta):
#	var motion = move_and_slide(dir * SPEED, Vector2.UP)
	var motion : KinematicCollision2D = move_and_collide(dir * SPEED * delta)
#	if motion != null:
#		if motion.collider.is_in_gropu("lasers"):
#			pass
#		self.queue_free()
#		pass
	pass

func _on_Timer_timeout():
	self.queue_free()
	pass
