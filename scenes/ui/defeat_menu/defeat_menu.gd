extends Control

#@onready var message: Label = $MarginContainer/VBoxContainer/Message
@onready var score: Label = $MarginContainer/VBoxContainer/Score

func _ready():
	score.text = "Score: " + str(GameState.player_score)

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/MainMenu.tscn")
