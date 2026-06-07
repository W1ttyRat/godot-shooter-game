extends Node3D

#var player_lives = 5
#var player_score = 0
@onready var score: Label = %Score
@onready var lives: Label = $Lives
@onready var player = $Player

func _ready():
	GameState.player_lives = 5
	GameState.player_score = 0
	lives.text = "Lives: " + str(GameState.player_lives)
	score.text = "Score: " + str(GameState.player_score)

func increase_score():
	#player_score += 1
	#score.text = "Score: " + str(player_score)
	GameState.player_score += 1
	score.text = "Score: " + str(GameState.player_score)
	
	
func do_poof(mob_global_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	
	var poof = SMOKE_PUFF.instantiate()
	
	add_child(poof)
	poof.global_position = mob_global_position
	
#func 

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
	get_tree().change_scene_to_file("res://DefeatMenu.tscn")
	#GameState.player_lives = 0





func _on_player_current_health(new_health: int) -> void:
	lives.text = "Lives: " + str(new_health)
	
