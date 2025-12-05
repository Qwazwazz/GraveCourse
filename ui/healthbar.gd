class_name HealthBar extends ProgressBar

var stats: Stats :
	set(new_stats):
		stats = new_stats
		if stats is Stats:
			update_health_bar()
			stats.health_changed.connect(_on_health_changed)

func _ready() -> void:
	modulate = Color.TRANSPARENT

func update_health_bar() -> void:
	var health_percent = stats.health / stats.max_health * 100
	value = clamp(health_percent, 0, max_value)

func _on_health_changed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0).from(Color.WHITE)
	update_health_bar()
	if value <= 0: hide()
