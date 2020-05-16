extends Area2D

var points

# Called when the node enters the scene tree for the first time.
func _ready():
	points = 10

func _on_Banana_body_entered(body):
	if body.name == "PlayerCharacter":
		get_node("/root/LevelController").addScore(points)
		self.queue_free()
