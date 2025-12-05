class_name Stats extends Resource

@export var health: = 1.0 :
	set(value):
		var previous_health = health
		health = value
		if previous_health != health: health_changed.emit()
		if health <= 0: no_health.emit()

@export var max_health: = 1.0

signal no_health()
signal health_changed()
