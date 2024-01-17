extends Label

@onready var player = $"../../Player"


func _process(delta):
	self.text = str(get_parent().health)
	pass
