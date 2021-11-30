extends Node2D

export var interval: float
export var flash : bool = false

var time: float

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(1.0, 1.0, 0.0, 1.0),
		  Color(0.0, 1.0, 1.0, 1.0),
		  Color(1.0, 0.0, 1.0, 1.0),
		  Color(0.0, 0.0, 1.0, 1.0)]
		
func _ready():
	self.get_parent().modulate = colors[Globals.rnd.randi_range(0, colors.size()-1)];
	pass
	
	
func _process(delta):
	if flash == false:
		return
		
	time += delta
	if time > interval:
		time = 0
		self.get_parent().modulate = colors[Globals.rnd.randi_range(0, colors.size()-1)];
	pass
	
