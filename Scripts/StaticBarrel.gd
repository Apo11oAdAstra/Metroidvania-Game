tool
extends Area2D

#settings
var launchVelocity = 1000
var launchDuration = 20
var enableGravity = false

#state vars
var holding

func _get(property):
	if property == "launchVelocity":
		return launchVelocity
	if property == "launchDuration":
		return launchDuration
	if property == "enableGravity":
		return enableGravity

func _set(property, value):
	if property == "launchVelocity":
		launchVelocity = value
		return true
	if property == "launchDuration":
		launchDuration = value
		return true
	if property == "enableGravity":
		enableGravity = value
		return true

func _get_property_list():
	return [
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "launchVelocity",
			"type": TYPE_INT
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "launchDuration",
			"type": TYPE_INT
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "enableGravity",
			"type": TYPE_BOOL
		}
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	holding = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#self.rotate(PI/60)
	
	#handle delayed barrel launching
	if holding and Input.is_action_just_pressed("ui_accept"):
		holding.launch(Vector2(0, -1).rotated(self.get_global_rotation()) * launchVelocity, enableGravity, launchDuration)
		holding = null

func _on_StaticBarrel_body_entered(body):
	holding = body
	holding.disableMovement(self.get_global_position())

