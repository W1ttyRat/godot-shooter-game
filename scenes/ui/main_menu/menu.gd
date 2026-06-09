extends Control


func _ready():
	#preload("res://game.tscn")
	preload("res://scenes/ui/pause_menu/PauseMenu.tscn")

func _on_play_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/options_menu/Options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
