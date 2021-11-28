extends Node

func _physics_process(_delta):
	if owner.position.x < 0:
		owner.position.x = 512
	elif owner.position.x > 512:
		owner.position.x = 0
	pass
	
	
