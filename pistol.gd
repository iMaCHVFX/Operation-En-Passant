extends Node2D
@onready var bullet = preload("res://bullet.tscn") 
var b
@onready var sprite_2d = $Sprite2D
@onready var barrel = $barrel
@export var player: Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

func _physics_process(delta):
	#var direction = position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed('shoot'):
		var bullet = bullet.instantiate()
		bullet.speed = 800	
			
				
		bullet.global_transform = barrel.global_transform
		
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(bullet)
		
		
	
	pass
