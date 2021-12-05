extends KinematicBody2D


func _physics_process(_delta):
	var motion = Vector2(0, 40)
	self.move_and_slide(motion)
	pass


func _on_Area2D_Collect_body_entered(body):
	if body.is_in_group("players"):
		body.inc_score(Globals.PTS_FOR_DIAMOND)
		self.queue_free()
	pass
