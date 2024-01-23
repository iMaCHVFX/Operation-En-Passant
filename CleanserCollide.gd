extends CollisionShape2D
@export var explosionV2 : PackedScene 
@onready var tileMap = get_node("/root/World/64")
@export var knockback = 350 

# Called when the node enters the scene tree for the first time.
func _ready():
	await(get_tree().create_timer(1)).timeout
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_rigid_body_2d_body_entered(body):
	
	tileMap.collide = true
	tileMap.cleaserPos = get_parent().position
	
	

	var _particle = explosionV2.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	
	queue_free()	
	
	
	#print(get_parent().position.distance_to(player.position))
