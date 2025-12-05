extends Node

@export var enemy_scenes: Array[PackedScene]

var max_enemies: = 5

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func():
		var enemy_count = get_tree().get_node_count_in_group("enemies")
		if enemy_count < max_enemies:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(enemy_scenes.pick_random())
	)
