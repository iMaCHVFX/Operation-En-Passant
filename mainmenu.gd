extends Control


func _on_start_pressed():
	Prevscene.prev_scene = "res://mainmenu.tscn"
	get_tree().change_scene_to_file("res://world.tscn")
	

func _on_tutorial_pressed():
	Prevscene.prev_scene = "res://mainmenu.tscn"
	get_tree().change_scene_to_file("res://tutorial.tscn")
	
	pass


func _on_settings_pressed():
	Prevscene.prev_scene = "res://mainmenu.tscn"
	get_tree().change_scene_to_file("res://chessboard.tscn")
	
	


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
