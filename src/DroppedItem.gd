extends Node2D

var side : int

func _physics_process(delta):
	self.position.y += delta * 50
	pass
	

