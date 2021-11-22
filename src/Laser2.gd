extends KinematicBody2D

const SPEED = 50000

var dir = Vector2(1, 0)

func _ready():
	pass


func _physics_process(delta):
	var motion = move_and_slide(dir * SPEED * delta, Vector2.UP)
	pass

func _on_Timer_timeout():
	self.queue_free()
	pass
