extends Node2D

func show_ship(pcent):
	$Mag_Ship.visible = false
	
	var height = $White_Ship.texture.get_height() #* 2 # 2 since it's scaled
	var pixels = pcent * height / 100
#	$White_Ship.region_enabled = true
	$White_Ship.region_rect.position.y = height-pixels
	$White_Ship.region_rect.size.y = pixels
	$White_Ship.position.y = ((height-pixels)*2)-18#-pixels#15 #height#50#
	pass


func show_fuel(pcent):
	show_ship(100)#$White_Ship.region_enabled = false

	$Mag_Ship.visible = true
	var height = $Mag_Ship.texture.get_height() #* 2 # 2 since it's scaled
	var pixels = pcent * height / 100
#	$Mag_Ship.region_enabled = true
	$Mag_Ship.region_rect.position.y = height-pixels
	$Mag_Ship.region_rect.size.y = pixels
	$Mag_Ship.position.y = ((height-pixels)*2)-18#-pixels#15 #height#50#
	pass
	
	
