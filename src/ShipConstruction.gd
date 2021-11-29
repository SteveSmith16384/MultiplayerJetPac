extends Node2D

export var side : int
var level : int = 0  # SHip 1-3 then fuel


func _ready():
	show_ship(0)
	$AudioStreamPlayer_Loaded.stream = load("res://assets/sfx/sfx_movement_portal" + str(side+1) + ".wav")
	pass
	
	
func update_spaceship():
	level += 1
	$AudioStreamPlayer_Loaded.play()
	if level <= 3:
		show_ship(level*33)
	else:
		show_fuel((level-3)*17)
	pass
	
	
func show_ship(pcent):
	if pcent > 100:
		pcent = 100
		
	$Mag_Ship.visible = false
	
	var height = $White_Ship.texture.get_height() #* 2 # 2 since it's scaled
	var pixels = pcent * height / 100
#	$White_Ship.region_enabled = true
	$White_Ship.region_rect.position.y = height-pixels
	$White_Ship.region_rect.size.y = pixels
	$White_Ship.position.y = ((height-pixels)*2)-18#-pixels#15 #height#50#
	pass


func show_fuel(pcent):
	if pcent > 100:
		pcent = 100
		
	show_ship(100)#$White_Ship.region_enabled = false

	$Mag_Ship.visible = true
	var height = $Mag_Ship.texture.get_height() #* 2 # 2 since it's scaled
	var pixels = pcent * height / 100
#	$Mag_Ship.region_enabled = true
	$Mag_Ship.region_rect.position.y = height-pixels
	$Mag_Ship.region_rect.size.y = pixels
	$Mag_Ship.position.y = ((height-pixels)*2)-18#-pixels#15 #height#50#
	pass
	
	
