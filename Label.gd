extends Label
@onready var player = $"../../Player"


func _process(delta):
	self.text = str(abs(get_parent().velocity.x) as int)
	pass
