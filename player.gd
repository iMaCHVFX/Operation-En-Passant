class_name PlayerEntity
extends CharacterBody2D


@onready var marker_2d = $Marker2D
@onready var perfect = $Marker2D/Perfect
@onready var late = $Marker2D/Late
@onready var good = $Marker2D/Good
@onready var bad = $Marker2D/Bad
@onready var left_arm = $Marker2D/LeftArm
@onready var right_arm = $Marker2D/RightArm

const GLOBAL_FRICTION = 0.14
const Y_TO_X_ON_SLOPE = 500
const SPEED_ORIGINAL = 320.0
@export var SPEED = 320.0
@export var JUMP_VELOCITY = -400.0
const PUSH_FORCE = 80.0
const PERFECT = 1
const GOOD = 2
const LATE = 3
const BAD = 4
const FRAME_WINDOW = 4
@export var acceleration = 0.5
const air_acceleration = 0
@export var friction = 0.14
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var counter: int = 0
var willFade: bool = false
var timingWindow: int = 0
var mousePos=Vector2(0.0,0.0)
#var b
@export var health = 200
var highestVel : Vector2 
var prevDirection
var direction
var testCounter = 0
var prevDir = 0
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
		
		
	if SPEED > SPEED_ORIGINAL:
		SPEED -= 0.01
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		counter = 0
	elif is_on_floor() and SPEED >= SPEED_ORIGINAL + 1 and counter > FRAME_WINDOW:
		SPEED = SPEED_ORIGINAL
	else:
		if counter >= 60:
			counter = 0
		else:
			counter += 1
	if is_on_floor() and get_floor_angle() > 0.5 or get_floor_angle() < 0.4:
		if friction < 0.14:
			friction += 0.005
	elif not is_on_floor():
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
					
					if velocity.y >= Y_TO_X_ON_SLOPE:
						SPEED += (velocity.y / 2) + 50.0
					else:
						SPEED += 50.0
				GOOD:
					good.visible = true
					good.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					bad.visible = false
					perfect.visible = false
					late.visible = false
					if velocity.y >= Y_TO_X_ON_SLOPE:
						SPEED += (velocity.y / 2) + 25.0
					else:
						SPEED += 25.0
				LATE:
					late.visible = true
					late.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					good.visible = false
					bad.visible = false
					perfect.visible = false
					if velocity.y >= Y_TO_X_ON_SLOPE:
						SPEED += (velocity.y / 2) + 15.0
					else:
						SPEED += 15.0 
				BAD:
					bad.visible = true
					bad.modulate.a = 1.0
					willFade = true
					timingWindow = counter
					perfect.visible = false
					late.visible = false
					good.visible = false
					if velocity.y >= Y_TO_X_ON_SLOPE:
						SPEED += (velocity.y / 2) + 5.0
					else:
						SPEED += 5.0 
				
				
			
		
	
	# Get the input direction and handle the movement/deceleration.
	prevDir = direction
	direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		if is_on_floor():
			velocity.x = lerpf(velocity.x, direction * SPEED, acceleration)
		else:
				if prevDir == 0:
					if velocity.x > 0:
						prevDir = 1
					elif velocity.x < 0:
						prevDir = -1	
				if prevDir != direction:
					velocity.x *= -1 + acceleration/SPEED * direction
					
				else:
					if velocity.x == 0:
						velocity.x += acceleration * direction
					else:
						velocity.x += acceleration/SPEED * direction

		
	elif is_on_floor() and direction == 0:
		
		velocity.x = lerpf(velocity.x, 0, friction)	
		
	#up slope = ~0.4 and is less than 0.5
	if get_floor_angle() > 0.4 and get_floor_angle() < 0.5 and velocity.x > 500:
		friction = 0 
		
		
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
	
	#print(counter)
	#print(is_on_floor(), " vel x: ", int(velocity.x), " vel y: ", int(velocity.y), " friction: ", friction, " angle: ", get_floor_angle())
	
	
	
	

