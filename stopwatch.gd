extends Label

var time_elapsed: float = 0.0
@onready var stopwatch: Label = $"."


func _process(delta: float) -> void:
	time_elapsed += delta
	
	var minutes: int = fmod(time_elapsed, 3600) / 60
	var seconds: int = fmod(time_elapsed, 60)
	
	stopwatch.text = "%02d:%02d" % [minutes, seconds]
