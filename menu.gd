extends Control


func _ready():
	preload("res://game.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
