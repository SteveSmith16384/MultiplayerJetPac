extends Node2D

var spawned_item_class = preload("res://SpawnedItem.tscn")
var dropped_item_class = preload("res://DroppedItem.tscn")

var level_stage = 1 # SHip 1-3 then fuel

func _ready():
	spawn_item()
	
	$ShipConstruction.show_ship(33)
	$ShipConstruction.show_fuel(33)
	pass


func spawn_item():
	var item = spawned_item_class.instance()
	if level_stage == 1:
		item.type = Globals.ObjectType.Ship1
	elif level_stage == 2:
		item.type = Globals.ObjectType.Ship2
	elif level_stage == 3:
		item.type = Globals.ObjectType.Ship3
	else:
		item.type = Globals.ObjectType.Fuel
	item.get_node("ItemSprites").show_item(item.type)
	item.position = Vector2(Globals.rnd.randi_range(50, 450), -10)
	add_child(item)
	pass
	
	
func _on_DropzoneArea2D_body_entered(body):
	if body.is_in_group("players"):
		if body.is_carrying_item():
			var dropped_item = dropped_item_class.instance()
			dropped_item.position.x = $DropzoneArea2D.position.x
			dropped_item.position.y = body.position.y
			dropped_item.get_node("ItemSprites").show_item(body.get_carried_item_type())
			self.add_child(dropped_item)

			body.remove_item()
			pass
	pass


func _on_LandingArea2D_body_entered(body):
	pass


func _on_LandingArea2D_area_entered(area):
	if area.owner.is_in_group("dropped_items"):
		area.owner.queue_free()

		level_stage += 1
		if level_stage < 10:
			self.spawn_item()
		else:
			# todo - next level!
			pass
		pass
	pass
