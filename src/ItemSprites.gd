extends Node2D


func hide_all():
	$Fuel.visible = false
	$Ship1_1.visible = false
	$Ship1_2.visible = false
	$Ship1_3.visible = false
	pass
	
	
func show_item(type):
	match(type):
		Globals.ObjectType.Fuel:
			$Fuel.visible = true
		Globals.ObjectType.Ship1:
			$Ship1_1.visible = true
		Globals.ObjectType.Ship2:
			$Ship1_2.visible = true
		Globals.ObjectType.Ship3:
			$Ship1_3.visible = true
	pass
	

