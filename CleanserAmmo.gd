extends RigidBody2D
const Player = preload("res://player.gd")


var direction: Vector2
var speed
var maxtime = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	apply_central_impulse(Vector2.RIGHT.rotated(global_rotation) * speed)
	var timer = Timer.new()
	timer.wait_time = maxtime
	timer.autostart = true
	add_child(timer)
	
	timer.timeout.connect(on_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_timeout():
	self.queue_free()
