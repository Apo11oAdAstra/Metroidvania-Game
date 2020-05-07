extends KinematicBody2D

#character settings
var gravity = Vector2(0, 9.8)
var acceleration = Vector2(150, 0)
var friction = 10

#state variables
var velocity = Vector2()
var input = Vector2()
var right = true
var jump_counter
var launchCounter
var launchGravity
var launchDuration
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_counter = 0
	launchCounter = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if launchCounter == 0:
		if right:
			velocity.x = acceleration.x
		else:
			velocity.x = -acceleration.x
			
		#process gravity
		velocity += gravity
		
		#process friction
		if input.x == 0:
			if is_on_floor():
				velocity.x /= friction
		
	elif launchCounter > 0:
		#check if gravity is enabled
		if launchGravity:
			velocity += gravity
		
		#disable inputs while being launched
		if launchDuration == launchCounter:
			launchCounter = 0
		else:
			launchCounter += 1
				
	#actually move
	velocity = move_and_slide(velocity, Vector2(0, -1))

func launch(launchVect, enableGrav, duration):
	velocity = launchVect
	launchGravity = enableGrav
	launchDuration = duration
	
	self.show()
	launchCounter = 1

func disableMovement(position):
	self.hide()
	self.set_global_position(position)
	velocity = Vector2(0,0)
	launchCounter = -1


func _on_edge_detector_body_exited(body):
	if not body.name == "PlayerCharacter":
		self.set_scale(Vector2(-1,1) * self.get_scale())
		right = not right
