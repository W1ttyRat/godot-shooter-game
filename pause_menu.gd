extends Control




func _on_continue_pressed() -> void:
	print("continue pressed")
	get_tree().paused = false
	hide()
	
	


func _on_quit_pressed() -> void:
	print("quit pressed")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")
