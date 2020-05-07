extends Area2D

#settings
var speed = 200
var duration = 200
var enableGravity = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.rotate(PI/60)

func _on_StaticBarrel_body_entered(body):
	body.launch(Vector2(0, -1).rotated(self.get_global_rotation()) * speed, enableGravity, duration)
