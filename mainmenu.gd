extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	Prevscene.prev_scene = "res://mainmenu.tscn"

func _on_tutorial_pressed():
	#get_tree().change_scene_to_file("res://tutorial.tscn"
	Prevscene.prev_scene = "res://mainmenu.tscn"
	pass


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://optionmenumenu.tscn")
	Prevscene.prev_scene = "res://mainmenu.tscn"
	


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
