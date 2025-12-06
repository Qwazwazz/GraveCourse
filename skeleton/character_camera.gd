class_name CharacterCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("character_camera")

func apply_screenshake(amount: float, duration: float = 0.3) -> void:
	var tween = create_tween()
	tween.tween_method(shake, amount, 0.0, duration)

func shake(amount: float) -> void:
	offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * amount
