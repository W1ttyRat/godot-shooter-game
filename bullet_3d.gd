extends Area3D

var bullet_speed: float = GameState.bullet_speed
var bullet_range: float = GameState.bullet_range

var travelled_distance = 0.0

func _physics_process(delta):
	position += -transform.basis.z * bullet_speed * delta
	travelled_distance += bullet_speed * delta
	if travelled_distance > bullet_range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
	
	
	
