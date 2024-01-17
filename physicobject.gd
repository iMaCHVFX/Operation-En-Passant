extends RigidBody2D

@onready var objectthing = $CollisionShape2D
@onready var objectthing_sprite = $Sprite2D
@onready var raycast = $RayCast2D

var is_on_floor: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor:
		objectthing.position.y = 20
		objectthing_sprite.position.y = 20
		
	pass


func _physics_process(delta):
	is_on_floor = false
	var body = raycast.get_collider()
	if is_instance_valid(body) && body.name == "Floor":
		is_on_floor = true


