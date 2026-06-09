extends RigidBody3D

signal died()

var health = GameState.mob_health
#var speed = 3.0
var speed = randf_range(2.0, 4.0)
var is_knocked = false


@onready var bat_model: Node3D = %bat_model
#@onready var timer: Timer = %Timer
@onready var timer: Timer = $DeathTimer
@onready var knockbackTimer: Timer = $KnockbackTimer
@onready var hurt_sound: AudioStreamPlayer3D = $HurtSound
@onready var ko_sound: AudioStreamPlayer3D = $KOSound
#@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D
#@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	if is_knocked:
		knockbackTimer.start()
		is_knocked = false
	else:
		var direction = global_position.direction_to(player.global_position)
		direction.y = 0.0
		
		if direction.length_squared() > 0.0:
			direction = direction.normalized()
			linear_velocity = direction * speed
		
		bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + (-0.5*PI)

func take_damage():
	if health == 0:
		return
	
	bat_model.hurt()
	
	health -= 1
	
	hurt_sound.play()
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		
		var direction = -1.0 * global_position.direction_to(player.global_position)
		
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		
		apply_central_impulse(direction * 10.0 + random_upward_force)
		
		
		timer.start()
		
		lock_rotation = false
		
		
		
		ko_sound.play()
	
func fly_backwards(body):
	#var away = global_position - player.global_position
	var away = global_position - body.global_position
	away.y = 0.0
	
	away = away.normalized()
	
	var strength = 20 * (1.0 + randf_range(0.0, 5.0))
	sleeping = false
	
	apply_central_impulse(away * strength)
	
	is_knocked = true


func _on_timer_timeout() -> void:
	queue_free()
	died.emit()


func _on_body_entered(body: Node) -> void:
	if health == 0:
		return
		
	if body.has_method("player_take_damage"):
		body.player_take_damage()
	fly_backwards(body)
		
	
