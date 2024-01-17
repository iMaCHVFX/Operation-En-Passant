extends Node

@onready var throok = $"../.."
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func start():
	timer.start(randf_range(0.5, 3.0))
	pass # Replace with function body.


func _on_timer_timout():
	timer.start(randf_range(2.0, 20.0))
