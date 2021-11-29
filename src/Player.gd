extends KinematicBody2D

const ACCELERATION = 20 #0#3500
const MAX_SPEED_WALK_X = 5000/50
const MAX_SPEED_X = 250
const MAX_SPEED_Y = 200
const AIR_RESISTANCE = .05
const GRAVITY = 10#450
const JUMP_FORCE = 50#800
const MAX_BULLETS = 100

const laser_class = preload("res://Laser2.tscn")

onready var walking_sprite = $Sprite
onready var flying_sprite = $FlyingSprites
onready var animationPlayer = $AnimationPlayer

var motion = Vector2.ZERO
var last_dir : int = 1 # -1 or 1
var can_shoot = true
var invincible = true
var alive = true
var side : int
var is_on_floor = false
var carrying #: Globals.ObjectType
onready var main = get_tree().get_root().get_node("World")
var bullet_count : int = 0

func _physics_process(_delta):
	if alive == false:
		return
		
	if main.game_over:
		return
		
	var x_input = Input.get_action_strength("move_right" + str(side)) - Input.get_action_strength("move_left" + str(side))
	
	if x_input != 0:
		last_dir = sign(x_input)
		
	if is_on_floor:
		walking_sprite.visible = true
		flying_sprite.visible = false
		
		if x_input != 0:
			animationPlayer.play("Run")
			# Move straight away
			motion.x = x_input * MAX_SPEED_WALK_X
		else:
			animationPlayer.play("Stand")
	else:
		walking_sprite.visible = false
		flying_sprite.visible = true
		
		animationPlayer.play("Flying")
		
		# Accelerate with jetpac
		motion.x += x_input * ACCELERATION
		motion.x = clamp(motion.x, -MAX_SPEED_X, MAX_SPEED_X)
	
	# Slow player down
	if is_on_floor:
		if x_input == 0:
			motion.x = 0
	else:
		motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
		pass
			
	motion.y += GRAVITY
	if Input.is_action_pressed("jump"+str(side)):
		motion.y -= JUMP_FORCE
			
	motion.y = clamp(motion.y, -MAX_SPEED_Y, MAX_SPEED_Y)

	walking_sprite.flip_h = motion.x > 0
	flying_sprite.flip_h = motion.x > 0
	
	motion = move_and_slide(motion, Vector2.UP)
	
	# Wrap
#	if self.position.x < 0:
#		self.position.x = 512
#	elif self.position.x > 512:
#		self.position.x = 0
		
	if self.position.y < 20:
		self.position.y = 20
		motion.y = motion.y * -0.7

	if can_shoot:
		if Input.is_action_pressed("primary_fire"+str(side)):
			if bullet_count < MAX_BULLETS:
				var laser = laser_class.instance()
				if last_dir == -1:
					laser.position = $MuzzlePosition_Left.global_position
				else:
					laser.position = $MuzzlePosition_Right.global_position
				laser.dir = Vector2(last_dir, 0)
				main.add_child(laser)
				can_shoot = false
				bullet_count += 10
			else:
				bullet_count -= 1
				pass
		else:
			bullet_count -= 1
		print(str(bullet_count))
		if bullet_count < 0:
			bullet_count = 0
	pass
	

func _on_FloorArea2D_body_entered(body):
	if body.is_in_group("floors"):
		is_on_floor = true
	pass


func _on_FloorArea2D_body_exited(body):
	if body.is_in_group("floors"):
		is_on_floor = false
		main.show_explosion(self)
	pass


func _on_CanShootTimer_timeout():
	can_shoot = true
	pass
	
	
func carry_item(type):
	carrying = type
	$ItemSprites.show_item(type)
	pass

	
func remove_item():
	self.carrying = null
	$ItemSprites.hide_all()
	pass

	
func is_carrying_item():
	return self.carrying != null
	pass


func get_carried_item_type():
	return carrying


func _on_InvincibleTimer_timeout():
	invincible = false
	pass


func die():
	if invincible:
		return
		
	self.position = Vector2(-1000, -1000)
	alive = false
	main.show_explosion(self)
	$RespawnTimer.start()
	pass
	

func _on_RespawnTimer_timeout():
	alive = true
	invincible = true
	motion = Vector2()
	main.set_player_start_pos(self)
	$InvincibleTimer.start()
	pass
