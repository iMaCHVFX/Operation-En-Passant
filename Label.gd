extends Label
@onready var player: CharacterBody2D = get_node("/root/World/Player")


func _process(delta):
	self.text = str("X: ", abs(get_parent().velocity.x as int), " Y: ", abs(get_parent().velocity.y as int))
	pass
