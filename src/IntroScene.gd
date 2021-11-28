extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	for i in range(0,4):
		if Input.is_action_just_pressed("primary_fire" + str(i)) or Input.is_action_just_pressed("jump" + str(i)):
			get_tree().change_scene("res://SelectPlayersScene.tscn")
		pass
		