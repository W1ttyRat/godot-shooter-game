extends Control

@onready var upgrade_1: Button = $MarginContainer/HBoxContainer/Upgrade1
@onready var upgrade_2: Button = $MarginContainer/HBoxContainer/Upgrade2
@onready var upgrade_3: Button = $MarginContainer/HBoxContainer/Upgrade3

var upgrades = [
	{"title": "+10% atk speed", "desc": "Faster attacks", "apply": Callable(GameState, "upgrade_attack_speed")},
	{"title": "+10% move speed", "desc": "Move faster", "apply": Callable(GameState, "upgrade_move_speed")},
	{"title": "+1 bullet", "desc": "Shoot one more bullet", "apply": Callable(GameState, "upgrade_bullet_count")},
	{"title": "+bullet speed", "desc": "Faster bullets", "apply": Callable(GameState, "upgrade_bullet_speed")},
	{"title": "+range", "desc": "Bullets travel farther", "apply": Callable(GameState, "upgrade_bullet_range")},
]

var chosen_upgrades = []

func _ready() -> void:
	upgrades.shuffle()
	chosen_upgrades = upgrades.slice(0, 3)
	
	setup_button(upgrade_1, chosen_upgrades[0])
	setup_button(upgrade_2, chosen_upgrades[1])
	setup_button(upgrade_3, chosen_upgrades[2])
	
	if GameState.mob_spawn_timer <= 2:
		return
	else:
		GameState.mob_spawn_timer -= 0.4
	
func setup_button(button: Button, upgrade_data: Dictionary) -> void:
	button.text = upgrade_data["title"] + "\n" + upgrade_data["desc"]
	button.pressed.connect(func():
		upgrade_data["apply"].call()
		continue_game()
	)

func continue_game():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
