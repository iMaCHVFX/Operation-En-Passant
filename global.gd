extends Node
var is_dragging = false
var initStart : int
var secondRoom : int
var finalRoom : int


func _ready():
	randomize()
	initStart = randi() % 2
	secondRoom = randi() % 2
	finalRoom = randi() % 2
	print(initStart, secondRoom, finalRoom)
	pass
