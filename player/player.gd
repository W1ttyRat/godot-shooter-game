extends CharacterBody3D

signal current_health(new_health: int)

@onready var timer: Timer = %Timer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		# $Camera3D/gun_model = %gun_model
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.5
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		var pause_menu = preload("res://PauseMenu.tscn")
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		get_tree().current_scene.add_child(pause_menu.instantiate())
		
		
		
func _physics_process(delta):
	var move_speed: float = GameState.move_speed
	
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		shoot_bullet()

func shoot_bullet():
	const BULLET = preload("res://Bullet3D.tscn")
	
	var count: int = max(1, GameState.bullet_count)
	var spread: float = 0.04
	
	for i in range(count):
		var new_bullet = BULLET.instantiate()
		
		var middle: float = (count - 1) / 2.0
		var angle: float = (i - middle) * spread
		
		new_bullet.global_transform = %Marker3D.global_transform.rotated(Vector3.UP, angle)
		%Marker3D.add_child(new_bullet)
		
	timer.wait_time = GameState.attack_speed
	
	%Timer.start()
	$Camera3D/gun_model2/AnimationPlayer.play("shoot")
	%AudioStreamPlayer.play()
	
func player_take_damage():
	GameState.player_lives -= 1
	current_health.emit(GameState.player_lives)
	
	if GameState.player_lives <= 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		call_deferred("load_defeat_screen")
	
func load_defeat_screen():
	get_tree().change_scene_to_file("res://DefeatMenu.tscn")
	
	
	
	
	
	#print("player_Take_damage func")
	
	
	
