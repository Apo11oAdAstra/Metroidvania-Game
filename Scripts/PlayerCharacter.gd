extends KinematicBody2D

#character settings
var gravity = Vector2(0, 9.8)
var acceleration = Vector2(20, 0)
var friction = 10
var jump_force = 400
var sprite

#state variables
var velocity = Vector2()
var input = Vector2()
var right = true
var jump_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("marisa")
	jump_counter = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	#grab inputs
	input = Vector2(0,0)
	input.x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	input.y = float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	
	#process inputs
	velocity.x += input.normalized().x * acceleration.x
	
	#handle jumps
	if jump_counter > 100:
		jump_counter = 0
	if Input.is_action_just_pressed("ui_up") and jump_counter == 0:
		velocity.y = -jump_force
		jump_counter += 1
	if jump_counter >= 1:
		jump_counter += 1
	#process gravity
	velocity += gravity
	
	#process friction
	if input.x == 0:
		velocity.x /= friction
	
	#actually move
	velocity = move_and_slide(velocity)
	
	#flips the character horizontally
	if not input.x == 0:
		if input.x > 0 and right == false:
			sprite.set_scale(Vector2(1,1))
			right = true
		elif input.x < 0 and right == true:
			sprite.set_scale(Vector2(-1, 1))
			right = false
