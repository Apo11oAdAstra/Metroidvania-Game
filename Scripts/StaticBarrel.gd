extends Area2D

#settings
var speed = 1000
var duration = 20
var enableGravity = false

#state vars
var holding

# Called when the node enters the scene tree for the first time.
func _ready():
	holding = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.rotate(PI/60)
	
	#handle delayed barrel launching
	if holding and Input.is_action_just_pressed("ui_accept"):
		holding.launch(Vector2(0, -1).rotated(self.get_global_rotation()) * speed, enableGravity, duration)
		holding = null

func _on_StaticBarrel_body_entered(body):
	holding = body
	holding.disableMovement(self.get_global_position())

