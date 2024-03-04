extends Node

var colors = [Color.red, Color.green, Color.magenta, Color.yellow]


func _ready():
	if "side" in owner:
		if owner.side >= 0:
			self.get_parent().modulate = colors[owner.side];
	elif "side" in owner.owner:
		if owner.owner.side >= 0:
			self.get_parent().modulate = colors[owner.owner.side];
	pass
