extends KinematicBody2D

var side : int
var type

func _physics_process(_delta):
	var motion = Vector2(0, 40)
	self.move_and_slide(motion)
	pass
	


func _on_CollectArea2D_body_entered(body):
	if body.is_in_group("players"):
		if body.side == side:
			body.carry_item(type)
			body.inc_score(Globals.PTS_FOR_COLLECTING_SHIP)
			self.queue_free()
			pass
	pass
