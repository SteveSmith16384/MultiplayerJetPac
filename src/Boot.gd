extends Node2D

var started = false

func _process(delta):
	if started == false: 
		return
	
	position.y += delta * 60
	if position.y > 370:
		started = false
		var main = get_tree().get_root().get_node("World")
		main.show_explosion(self)
		main.hide_ships()
