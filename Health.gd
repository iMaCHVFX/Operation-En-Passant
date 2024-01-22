extends Label

@onready var player: CharacterBody2D = get_node("/root/World/Player")


func _process(delta):	
	
	self.text = str(get_parent().health)

