extends CollisionShape2D
@export var explosion : PackedScene 
@onready var player: CharacterBody2D = get_node("/root/World/Player")
var knockback = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	await(get_tree().create_timer(1)).timeout
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_rigid_body_2d_body_entered(body):
	
	if get_parent().position.distance_to(player.position) < 400:
		player.velocity += player.position.direction_to(get_parent().position) * -1 * knockback
	
	if body is PlayerEntity:
		return
	else:
		var _particle = explosion.instantiate()
		_particle.position = global_position
		_particle.rotation = global_rotation
		_particle.emitting = true
		get_tree().current_scene.add_child(_particle)
	
		queue_free()	
	
	
	print(get_parent().position.distance_to(player.position))