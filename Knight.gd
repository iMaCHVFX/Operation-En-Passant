extends CharacterBody2D
var currentPos


func _ready():
	currentPos = position





func _input(event):
	if event.is_action_pressed("move_right"):
		currentPos[0] += 64
		
	if event.is_action_pressed("move_left"):
		currentPos[0] -= 64
		
	if event.is_action_pressed("move_up"):
		currentPos[1] -= 64
		
	if event.is_action_pressed("move_down"):
		currentPos[1] += 64
		
	self.position = Vector2(currentPos[0], currentPos[1])

