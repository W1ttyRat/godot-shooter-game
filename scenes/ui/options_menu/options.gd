extends Control

@onready var music: Button = $MarginContainer/VBoxContainer/Music
@onready var h_slider: HSlider = $MarginContainer/VBoxContainer/HSlider

func _ready() -> void:
	h_slider.value = GameState.music_volume

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/MainMenu.tscn")


func _on_music_pressed() -> void:
	if GameState.music_enabled == true:
		GameState.music_enabled = false
		music.add_theme_color_override("font_color", Color("red"))
	elif GameState.music_enabled == false:
		GameState.music_enabled = true
		music.add_theme_color_override("font_color", Color("green"))
		


func _on_h_slider_value_changed(value: float) -> void:
	#print(value)
	GameState.set_music_volume(value)
