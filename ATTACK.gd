extends Node

@onready var cognite_node = $".."

# Called when the node enters the scene tree for the first time.
func start():
	cognite_node.attacking = true;
