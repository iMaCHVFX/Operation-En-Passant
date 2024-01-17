class_name Throok
extends CharacterBody2D

@onready var wall_raycast_left = $Wall_Check/Wall_Raycast_Left as RayCast2D
@onready var wall_raycast_right = $Wall_Check/Wall_Raycast_Right as RayCast2D
@onready var floor_raycast_left = $Floor_Check/Floor_Raycast_Left as RayCast2D
@onready var floor_raycast_right = $Floor_Check/Floor_Raycast_Right as RayCast2D
@onready var player_tracker_raycast = $Player_Tracker_Pivot/Player_Tracker_Raycast as RayCast2D
@onready var player_tracker_pivot = $Player_Tracker_Pivot as Node2D 
@onready var sprite_2d = $Sprite2D as Sprite2D

@onready var chase_timer = $ChaseTimer as Timer

@export var wander_speed : float = 40.0
@export var chase_speed : float = 80.0

var current_speed : float = 0.0
var player_found : bool = false
var player = preload("res://player.tscn")

enum States {
	Wander,
	Chase
}

var current_state = States.Wander

func _ready():
	player = get_tree().get_first_node_in_group("player")  
	chase_timer.timeout.connect(on_timer_timeout)
	
func _physics_process(delta):
	handle_vision()
	track_player()
	

func track_player():
	if player == null:
		return
	var direction_to_player : Vector2 = Vector2(player.position.x, player.position.y) - player_tracker_raycast.position
	
	
	player_tracker_pivot.look_at(direction_to_player)




func handle_vision():
	if player_tracker_raycast.is_colliding():
		var collision_result = player_tracker_raycast.get_collider()
		
		if collision_result != player:
			return
		else:
			current_state = States.Chase
			chase_timer.start(1)
			player_found = true
	else:
		player_found = false

func on_timer_timeout():
	if not player_found:
		current_state = States.Wander
