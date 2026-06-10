extends Node

signal music_changed(enabled: bool, volume: float)

var player_score: int = 0
var player_lives: int = 5

var mob_spawn_timer: float = 5.0
var mob_health: int = 1

var boss_health: int = 10
var boss_speed: float = 2.0

var attack_speed: float = 0.4
var move_speed: float = 5.5
var bullet_count: int = 1
var bullet_speed: float = 10.0
var bullet_range: float = 10.0

var music_enabled: bool = true
var music_volume: float = 80.0

func set_music_volume(v: float) -> void:
	music_volume = v
	emit_signal("music_changed", music_enabled, music_volume)

func set_music_enabled(enabled: bool) -> void:
	music_enabled = enabled
	emit_signal("music_changed", music_enabled, music_volume)
	
func reset_run() -> void:
	player_score = 0
	player_lives = 5
	attack_speed = 0.4
	move_speed = 5.5
	bullet_count = 1
	bullet_speed = 10.0
	bullet_range = 10.0
	mob_health = 1
	mob_spawn_timer = 5.0
	

func upgrade_attack_speed():
	attack_speed *= 0.9
func upgrade_move_speed():
	move_speed *= 1.1
func upgrade_bullet_count():
	bullet_count += 1
func upgrade_bullet_speed():
	bullet_speed += 2
func upgrade_bullet_range():
	bullet_range += 4
