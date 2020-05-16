extends Control

# Declare member variables here. Examples:
var score
var scoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	scoreLabel = self.get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scoreLabel.text = "Score: " + str(score)

func addScore(pts):
	score = score + pts