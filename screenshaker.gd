class_name Screenshaker extends Node

@export var target_camera:CharacterCamera

func _ready() -> void:
	if target_camera is not CharacterCamera:
		target_camera = get_tree().get_first_node_in_group("character_camera")

func apply_screenshake(amount: float, duration: float = 0.3) -> void:
	target_camera.apply_screenshake(amount, duration)
