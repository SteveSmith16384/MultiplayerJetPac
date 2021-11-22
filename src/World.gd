extends Node2D

var spawned_item_class = preload("res://SpawnedItem.tscn")

func _ready():
	spawn_item()
	pass


func spawn_item():
	var item = spawned_item_class.instance()
	item.type = Globals.ObjectType.Fuel
	item.get_node("ItemSprites").show_item(Globals.ObjectType.Fuel)
	item.position = Vector2(Globals.rnd.randi_range(50, 450), 0)#340)
	add_child(item)
	pass
	
	
func _on_DropzoneArea2D_body_entered(body):
	if body.is_in_group("players"):
		if body.is_carrying_item():
			var clazz = preload("res://DroppedItem.tscn")
			var dropped_item = clazz.instance()
			dropped_item.position = body.position
			dropped_item.get_node("ItemSprites").show_item(body.get_carried_item_type())
			self.add_child(dropped_item)

			body.remove_item()
			pass
	pass


func _on_LandingArea2D_body_entered(body):
	pass


func _on_LandingArea2D_area_entered(area):
	if area.owner.is_in_group("dropped_items"):
		pass
	pass # Replace with function body.
