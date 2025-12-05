extends Node

const BOSS_ENEMY = preload("res://boss/boss.tscn")

@export var enemy_scenes: Array[PackedScene]

var max_enemies: = 5
var max_bosses: = 1

var game: Game = load("res://game.tres")

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func():
		var enemy_count = get_tree().get_node_count_in_group("enemies")
		
		if enemy_count < max_enemies:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(enemy_scenes.pick_random())
		
		var boss_count = get_tree().get_node_count_in_group("bosses")
		if boss_count < max_bosses and game.kills >= 15:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(BOSS_ENEMY)
	)
