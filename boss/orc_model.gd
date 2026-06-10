extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Walk")

func hurt() -> void:
	animation_player.play("HitReact")
	animation_player.queue("Walk")

func death() -> void:
	animation_player.play("Death")
