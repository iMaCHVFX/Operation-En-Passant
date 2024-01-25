extends Camera2D

@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

		
	pass
	
func _physics_process(delta):
	pass
	#if player.velocity.x >= 800.0:
	#	offset.x = 300
	#elif player.velocity.x <= -800.0:
	#	offset.x = -300
	
	#else:
	#	offset.x = 0
func _input(event):
	if Input.is_action_just_pressed("zoomin"):
		zoom.x += 0.02
		zoom.y += 0.02
	elif Input.is_action_just_pressed("zoomout"):
		zoom.x -= 0.02
		zoom.y -= 0.02
