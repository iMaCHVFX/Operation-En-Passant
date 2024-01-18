extends Node2D
@onready var bullet = preload("res://bullet.tscn") 
@onready var rocket = preload("res://rocket.tscn")
var b
@onready var sprite_2d = $Sprite2D
@onready var barrel = $barrel
var player: Node2D
var currentAmmo = rocket
@export var currentAmmoByString = "rocket"

# Called when the node enters the scene tree for the first time.
func _ready():

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	match currentAmmoByString:
		"rocket":
			currentAmmo = rocket
		"bullet":
			currentAmmo = bullet
	pass
	
	

func _physics_process(delta):
	#var direction = position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed('shoot'):
		
		var currentAmmo = currentAmmo.instantiate()
		
		match currentAmmoByString:
			"rocket":
				currentAmmo.speed = 1000.0
			"bullet":
				currentAmmo.speed = 800.0
			
		
			
				
		currentAmmo.global_transform = barrel.global_transform
		
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(currentAmmo)
		
		
	
	pass

