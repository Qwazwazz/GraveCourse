class_name SpawnPoint extends Marker2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(remove_from_group.bind("active_spawn_points"))
	visible_on_screen_notifier_2d.screen_exited.connect(add_to_group.bind("active_spawn_points"))
	pass

func spawn_enemy(enemy_scene: PackedScene) -> void:
	var enemy = enemy_scene.instantiate() as Node2D
	enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)
