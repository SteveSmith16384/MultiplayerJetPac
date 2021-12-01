extends Node2D

func _ready():
	Globals.player_nums.clear()
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://IntroScene.tscn")
		
	for i in range(0,4):
		if Input.is_action_just_pressed("primary_fire" + str(i)) or Input.is_action_just_pressed("jump" + str(i)):
			if Globals.player_nums.has(i) == false:
				Globals.player_nums.push_back(i)
				var human = find_node("SinglePlayerSprite_" + str(i))
				human.visible = true
				$AudioStreamPlayer_Joined.play()
				pass
			pass
		pass
		
	if Input.is_action_just_pressed("start_game"):
		if Globals.player_nums.size() > 0:
			get_tree().change_scene("res://World.tscn")
	pass
	

func _on_Timer_Flash_timeout():
	var label = find_node("Label")
	label.visible = not label.visible
	pass
