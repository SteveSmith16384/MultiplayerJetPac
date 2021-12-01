extends Node

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(1.0, 1.0, 0.0, 1.0),
		  Color(0.0, 1.0, 1.0, 1.0)]


func _ready():
	if "side" in owner:
		if owner.side >= 0:
			self.get_parent().modulate = colors[owner.side];
	elif "side" in owner.owner:
		if owner.owner.side >= 0:
			self.get_parent().modulate = colors[owner.owner.side];
	pass
