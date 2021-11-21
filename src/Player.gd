extends KinematicBody2D

const ACCELERATION =3500
const MAX_SPEED_WALK_X = 5000
const MAX_SPEED_X = 250
const MAX_SPEED_Y = 200
const AIR_RESISTANCE = 10
const GRAVITY = 450
const JUMP_FORCE = 800

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var is_on_floor = false

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		animationPlayer.play("Run")
		if is_on_floor:
			# Move straight away
			motion.x = x_input * MAX_SPEED_WALK_X * delta
		else:
			# Accelerate with jetpac
			motion.x += x_input * ACCELERATION * delta
			motion.x = clamp(motion.x, -MAX_SPEED_X, MAX_SPEED_X)

		# Clamp speed
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
	
	motion.y += GRAVITY * delta
	
	# Slow player down
	if is_on_floor:
		if x_input == 0:
			motion.x = 0
	else:
		motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
#			print("Is NOT on floor")
#			
#	else:
#		animationPlayer.play("Jump")
#		
#		if Input.is_action_pressed("ui_up"):
#			motion.y = -JUMP_FORCE
#		
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
#	pass
		
	if Input.is_action_pressed("ui_up"):
		motion.y -= JUMP_FORCE * delta
		
	motion.y = clamp(motion.y, -MAX_SPEED_Y, MAX_SPEED_Y)

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
	pass
	


func _on_FloorArea2D_body_entered(body):
	if body.is_in_group("floors"):
		is_on_floor = true
	pass


func _on_FloorArea2D_body_exited(body):
	if body.is_in_group("floors"):
		is_on_floor = false
	pass
