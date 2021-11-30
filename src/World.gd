extends Node2D

const player_class = preload("res://Player.tscn")
const spawned_item_class = preload("res://SpawnedItem.tscn")
const dropped_item_class = preload("res://DroppedItem.tscn")
const enemy_class = preload("res://Enemy.tscn")
const expl_class = preload("res://Explosion.tscn")

var game_over = false

func _ready():
	for side in Globals.player_nums: # range(0, 2):# todo - re-add 
		var player = player_class.instance()
		player.side = side
		set_player_start_pos(player)
		add_child(player)
		spawn_item(side, 0)
		
		if side > 0:
			# Position ship relative to dropzone
			var ship0 = $Ships/ShipConstruction_0
			var dropzone0 = $Ships/DropzoneArea_0
			var diff : Vector2 = dropzone0.position - ship0.position

			var ship = get_node("Ships/ShipConstruction_" + str(side))
			var dropzone = get_node("Ships/DropzoneArea_" + str(side))
			ship.position.x = dropzone.position.x - diff.x
			ship.position.y = dropzone.position.y - diff.y
	pass


func set_player_start_pos(player):
	var pos: Vector2 = get_node("StartPositions/StartPosition_" + str(player.side)).position
	player.position = pos
	pass
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://SelectPlayersScene.tscn")
	pass


func spawn_item(side, level):
	if game_over:
		return
		
	var item = spawned_item_class.instance()
	if level == 0:
		item.type = Globals.ObjectType.Ship1
	elif level == 1:
		item.type = Globals.ObjectType.Ship2
	elif level == 2:
		item.type = Globals.ObjectType.Ship3
	else:
		item.type = Globals.ObjectType.Fuel
	item.get_node("ItemSprites").show_item(item.type)
	item.position = Vector2(Globals.rnd.randi_range(50, 450), -10)
	item.side = side
	add_child(item)
	pass
	
	
func _on_LandingArea_0_area_entered(area):
	area_entered_landing_area(0, area)
	pass

	
func _on_LandingArea_1_area_entered(area):
	area_entered_landing_area(1, area)
	pass
	

func _on_LandingArea_2_area_entered(area):
	area_entered_landing_area(2, area)
	pass


func _on_LandingArea_3_area_entered(area):
	area_entered_landing_area(3, area)
	pass


func area_entered_landing_area(landing_side, area):
	#var parent = area.owner
	if area.owner.is_in_group("dropped_items") == false:
		return
		
	if area.owner.side != landing_side:
		return
		
	area.owner.queue_free()

	var spaceship = self.get_node("Ships/ShipConstruction_" + str(landing_side))
	spaceship.update_spaceship()
	if spaceship.level < 9:
		self.spawn_item(landing_side, spaceship.level)
	else:
		show_winner(landing_side)
		pass
	pass


func _on_DropzoneArea_0_body_entered(body):
	body_entered_dropzone_area($Ships/DropzoneArea_0, body)
	pass


func _on_DropzoneArea_1_body_entered(body):
	body_entered_dropzone_area($Ships/DropzoneArea_1, body)
	pass


func _on_DropzoneArea_2_body_entered(body):
	body_entered_dropzone_area($Ships/DropzoneArea_2, body)
	pass


func _on_DropzoneArea_3_body_entered(body):
	body_entered_dropzone_area($Ships/DropzoneArea_3, body)
	pass
	

func body_entered_dropzone_area(dropzone, body):
	if body.is_in_group("players") == false:
		return
		
	if body.is_carrying_item():
		if body.side == dropzone.side:
			var dropped_item = dropped_item_class.instance()
			dropped_item.position.x = dropzone.position.x
			dropped_item.position.y = body.position.y
			dropped_item.side = dropzone.side
#			print(str(dropped_item.side))
#			print(str(dropzone.side))
			dropped_item.get_node("ItemSprites").show_item(body.get_carried_item_type())
			self.add_child(dropped_item)

			body.remove_item()
			pass
	pass
	

func _on_SpaenEnemyTimer_timeout():
	if Globals.NO_ENEMIES:
		return
		
	if game_over:
		return
		
	var enemy = enemy_class.instance()
	add_child(enemy)
	pass


func show_explosion(owner):
	var expl = self.expl_class.instance()
	expl.position = owner.position
	call_deferred("add_child", expl)
	pass
	
	
func show_winner(side):
	if game_over:
		return
		
	game_over = true
	var label = self.find_node("WinnerLabel")
	label.text = "PLAYER " + str(side) + " IS THE WINNER!"
	
	var sprite = find_node("WinnerSprite")
	sprite.side = side

	var node = find_node("WinnerNode")
	node.visible = true
	pass
	

func enemy_destroyed():
	$AudioStreamPlayer_EnemyDestroyed.play()
	pass
	
	
