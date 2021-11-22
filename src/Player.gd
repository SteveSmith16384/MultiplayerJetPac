extends KinematicBody2D

const ACCELERATION = 3500
const MAX_SPEED_WALK_X = 5000
const MAX_SPEED_X = 250
const MAX_SPEED_Y = 200
const AIR_RESISTANCE = 10
const GRAVITY = 450
const JUMP_FORCE = 800

const laser_class = preload("res://Laser2.tscn")

var motion = Vector2.ZERO
var last_dir = 1 # -1 or 1
var can_shoot = true

onready var walking_sprite = $Sprite
onready var flying_sprite = $FlyingSprites
onready var animationPlayer = $AnimationPlayer

var is_on_floor = false

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		last_dir = sign(x_input)
		
	if is_on_floor:
		walking_sprite.visible = true
		flying_sprite.visible = false
		
		if x_input != 0:
			animationPlayer.play("Run")
			# Move straight away
			motion.x = x_input * MAX_SPEED_WALK_X * delta
		else:
			animationPlayer.play("Stand")
	else:
		walking_sprite.visible = false
		flying_sprite.visible = true
		
		animationPlayer.play("Flying")
		
		# Accelerate with jetpac
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED_X, MAX_SPEED_X)
	
	# Slow player down
	if is_on_floor:
		if x_input == 0:
			motion.x = 0
	else:
		motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
		
	motion.y += GRAVITY * delta
	if Input.is_action_pressed("ui_up"):
		motion.y -= JUMP_FORCE * delta
		
	motion.y = clamp(motion.y, -MAX_SPEED_Y, MAX_SPEED_Y)

	walking_sprite.flip_h = motion.x > 0
	flying_sprite.flip_h = motion.x > 0
	
	motion = move_and_slide(motion, Vector2.UP)
	
	# Wrap
	if self.position.x < 0:
		self.position.x = 512
	elif self.position.x > 512:
		self.position.x = 0
		
#	print(str(self.position.y))
	if self.position.y < 20:
		self.position.y = 20
		motion.y = motion.y * -0.7

	if can_shoot and Input.is_action_pressed("shoot_p1"):
		var laser = laser_class.instance()
		laser.position = $MuzzlePosition2D.global_position
		laser.dir = Vector2(last_dir, 0)
		var main = get_tree().get_root().get_node("World")
		main.add_child(laser)
		can_shoot = false
	pass
	


func _on_FloorArea2D_body_entered(body):
	if body.is_in_group("floors"):
		is_on_floor = true
	pass


func _on_FloorArea2D_body_exited(body):
	if body.is_in_group("floors"):
		is_on_floor = false
	pass


func _on_CanShootTimer_timeout():
	can_shoot = true
	pass # Replace with function body.
