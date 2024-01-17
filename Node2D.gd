extends Node2D

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass


func _input(event):
	
	if event is InputEventMouseMotion:
		sprite_2d.global_position.x = event.global_position.x
		sprite_2d.global_position.y = event.global_position.y - -200
		
