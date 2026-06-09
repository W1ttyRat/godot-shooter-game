extends Control

@onready var attack_speed: Label = $MarginContainer2/VBoxContainer/AttackSpeed
@onready var move_speed: Label = $MarginContainer2/VBoxContainer/MoveSpeed
@onready var bullet_count: Label = $MarginContainer2/VBoxContainer/BulletCount
@onready var bullet_speed: Label = $MarginContainer2/VBoxContainer/BulletSpeed
@onready var bullet_range: Label = $MarginContainer2/VBoxContainer/BulletRange
@onready var mob_health: Label = $MarginContainer2/VBoxContainer/MobHealth

func _ready():
	var atk_speed: String = "%.2f" % (1.0 / GameState.attack_speed)
	attack_speed.text = "Atk speed: " + atk_speed
	
	var speed: String = "%.2f" % GameState.move_speed
	move_speed.text = "Move speed: " + speed + "m/s"
	bullet_count.text = "Bullet count: " + str(GameState.bullet_count)
	bullet_speed.text = "Bullet speed: " + str(GameState.bullet_speed) + "m/s"
	bullet_range.text = "Bullet range: " + str(GameState.bullet_range) + "m"
	mob_health.text = "Mob health: " + str(GameState.mob_health)

func _on_continue_pressed() -> void:
	#print("continue pressed")
	get_tree().paused = false
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	


func _on_quit_pressed() -> void:
	print("quit pressed")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/MainMenu.tscn")
