extends Node2D


func _on_AnimatedSprite_animation_finished():
	self.queue_free()
	pass
