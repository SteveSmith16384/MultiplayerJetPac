extends Node2D


func _ready():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("default")
	pass
	
	
func _on_AnimatedSprite_animation_finished():
	self.queue_free()
	pass


