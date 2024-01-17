class_name PlayerEntity
extends CharacterBody2D


@onready var marker_2d = $Marker2D
@onready var perfect = $Marker2D/Perfect
@onready var late = $Marker2D/Late
@onready var good = $Marker2D/Good
@onready var bad = $Marker2D/Bad
@onready var left_arm = $Marker2D/LeftArm
@onready var right_arm = $Marker2D/RightArm




var SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 80.0
const PERFECT = 1
const GOOD = 2
const LATE = 3
const BAD = 4
const FRAME_WINDOW = 4
const acceleration = 0.5
var friction = 0.14
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var counter: int = 0
var willFade: bool = false
var timingWindow: int = 0
var mousePos=Vector2(0.0,0.0)
#var b
var health = 200
var highestVel : Vector2 
var prevDirection
var direction
func _ready():
	perfect.visible = false
	bad.visible = false
	good.visible = false
	late.visible = false
	


func _process(delta):
	mousePos.x = get_global_mouse_position().x
	mousePos.y = get_global_mouse_position().y
	right_arm.look_at(mousePos)
	
	if mousePos.x > global_position.x:
		marker_2d.scale.x = 1
		perfect.flip_h = false 
		good.flip_h = false
		bad.flip_h = false
		late.flip_h = false
	elif mousePos.x < global_position.x:
		marker_2d.scale.x = -1
		perfect.flip_h = true
		good.flip_h = true
		bad.flip_h = true
		late.flip_h = true	
	
		

func _physics_process(delta):
	
	match timingWindow:
		PERFECT:
			perfect.modulate.a -= 0.03
			
		GOOD:
			good.modulate.a -= 0.03
			
		LATE:
			late.modulate.a -= 0.03  
			
		BAD:
			bad.modulate.a -= 0.03
			
			
	if bad.modulate.a == 0.0:
		bad.modulate.a = 1.0
		willFade = false
		bad.visible = false
	elif perfect.modulate.a == 0.0:
		perfect.modulate.a = 1.0
		willFade = false
		perfect.visible = false
	elif good.modulate.a == 0.0:
		good.modulate.a = 1.0
		willFade = false
		good.visible = false
	elif late.modulate.a == 0.0:
		late.modulate.a = 1.0
		willFade = false
		late.visible = false
		
		
	if SPEED > 300.0:
		SPEED -= 0.01
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		counter = 0
	elif is_on_floor() and SPEED >= 301.0 and counter > FRAME_WINDOW:
		SPEED = 300
	else:
		if counter >= 60:
			counter = 0
		else:
			counter += 1
	if is_on_floor():
		if friction < 0.14:
			friction += 0.005
	else:
		friction = 0.0
	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		if counter <= FRAME_WINDOW and counter > 0:
			
			friction = 0.0
			
			match counter:
				PERFECT:
					perfect.visible = true
					perfect.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					good.visible = false
					bad.visible = false
					late.visible = false
					
					SPEED += 50.0
				GOOD:
					good.visible = true
					good.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					bad.visible = false
					perfect.visible = false
					late.visible = false
					SPEED += 25.0
				LATE:
					late.visible = true
					late.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					good.visible = false
					bad.visible = false
					perfect.visible = false
					SPEED += 18.0
				BAD:
					bad.visible = true
					bad.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					perfect.visible = false
					late.visible = false
					good.visible = false
					SPEED += 5.0
				
				
			
		
	
	# Get the input direction and handle the movement/deceleration.
	# print(direction, " ", prevDirection," ", "speed: ", velocity.x as int, " ", "counter: ", counter)
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		
		#slows player down upon sudden change in direction (doesnt work? you never see 1 -1 or -1 1
		#see else statment for rest
		
		#if prevDirection != direction and prevDirection != 0 and direction != 0: 
		#	velocity.x += 200.0
		#	prevDirection = direction
			
		velocity.x = lerpf(velocity.x, direction * SPEED, acceleration)
		
			
	else:
		
		#if prevDirection != direction and prevDirection != 0 and direction != 0:
		#	velocity.x -= 200.0
		#	prevDirection = direction

			
		velocity.x = lerpf(velocity.x, 0, friction)
	
	
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)
			
	
	if velocity.y > highestVel.y:
		highestVel.y = velocity.y
	
	if velocity.x > highestVel.x:
		highestVel.x = velocity.x
		
		
		#debug print
	
	#print("X: ", abs(velocity.x), " ", abs(highestVel.x), " Y: ", abs(velocity.y), " ", abs(highestVel.y))
	
	
