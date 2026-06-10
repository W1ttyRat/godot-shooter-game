extends RigidBody3D

var health: int
var speed: float
#TODO: is a boss, animations, take damage, do damage, probably special effects, screams upon spawning
@onready var orc_model: Node3D = $OrcModel
@onready var wait_time: Timer = $WaitTime
@onready var death_timer: Timer = $DeathTimer
@onready var take_damage_sound: AudioStreamPlayer = $TakeDamageSound
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	speed = GameState.boss_speed
	health = GameState.boss_health

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	if direction.length_squared() > 0.0:
		direction = direction.normalized()
		linear_velocity = direction * speed
		
	orc_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func take_damage():
	if health == 0:
		return
	
	take_damage_sound.play()
	orc_model.hurt()
	wait_time.start()
	speed = 0
	
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		
		death_sound.play()
		orc_model.death()
		death_timer.start()
		
		lock_rotation = false
	
	
	


func _on_wait_time_timeout() -> void:
	speed = GameState.boss_speed


func _on_death_timer_timeout() -> void:
	queue_free()
