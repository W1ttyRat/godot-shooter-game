extends Node3D

@onready var score: Label = %Score
@onready var lives: Label = $Lives
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
#@onready var player = $Player

func _ready():
	GameState.player_lives = 5
	GameState.player_score = 0
	lives.text = "Lives: " + str(GameState.player_lives)
	score.text = "Score: " + str(GameState.player_score)
	
	_apply_music_settings()
	GameState.connect("music_changed", Callable(self, "_apply_music_settings"))

func increase_score():
	GameState.player_score += 1
	score.text = "Score: " + str(GameState.player_score)
	
	if GameState.player_score % 15 == 0:
		on_score_multiple_of_15(GameState.player_score)
	
	if GameState.player_score % 30 == 0:
		increase_mob_health()
	
func do_poof(mob_global_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	
	var poof = SMOKE_PUFF.instantiate()
	
	add_child(poof)
	poof.global_position = mob_global_position
	
func on_score_multiple_of_15(score: int) -> void:
	var upgrade_menu: PackedScene = preload("res://UpgradeMenu.tscn")

	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().current_scene.add_child(upgrade_menu.instantiate())

func increase_mob_health():
	GameState.mob_health += 1

func _apply_music_settings() -> void:
	var linear = clamp(GameState.music_volume / 100.0, 0.0, 1.0)
	background_music.volume_db = lerp(-80.0, 0.0, linear)
	
	if GameState.music_enabled:
		if not background_music.playing:
			background_music.play()
	else:
		background_music.stop()

func _on_mob_spawner_mob_spawned(mob: Variant) -> void:
	mob.died.connect(func on_mob_died():
		increase_score()
		do_poof(mob.global_position)
		)
	do_poof(mob.global_position)
	


func _on_kill_plane_body_entered(body: Node3D) -> void:
	#get_tree().reload_current_scene.call_deferred()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().call_deferred("change_scene_to_file", "res://DefeatMenu.tscn")
	#GameState.player_lives = 0





func _on_player_current_health(new_health: int) -> void:
	lives.text = "Lives: " + str(new_health)
	
