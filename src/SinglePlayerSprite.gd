extends Sprite

export var side : int

func set_side(s):
	side = s
	$SetColourFromSide._ready() # To set the colour
	pass
	
