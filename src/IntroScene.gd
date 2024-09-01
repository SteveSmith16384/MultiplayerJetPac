extends Node2D

func _ready():
	if Globals.RELEASE_MODE:
		OS.window_fullscreen = true
	$CanvasLayer/Label_Version.text = "VERSION " + Globals.VERSION
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		
	for i in range(0,4):
		if Input.is_action_just_pressed("primary_fire" + str(i)) or Input.is_action_just_pressed("jump" + str(i)):
			var _unused = get_tree().change_scene("res://SelectPlayersScene.tscn")
		pass
		
	$Rotated.rotate(delta)
	pass

func _on_Timer_Flash_timeout():
	var label = find_node("Label")
	label.visible = not label.visible
	pass
