class_name FlyingEnemy extends Node2D

const FEATHER_BURST_EFFECT = preload("res://crow/feather_burst_effect.tscn")

var game: Game = load("res://game.tres")

@export var direction: = Vector2.LEFT
@export var speed: = 75

@onready var sprite_2d: Sprite2D = $Anchor/Sprite2D
@onready var anchor: Node2D = $Anchor
@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

func _ready() -> void:
	var skeleton = get_tree().get_first_node_in_group("Skeleton") as Skeleton
	direction.x = sign(skeleton.global_position.x - global_position.x)
	anchor.scale.x = sign(direction.x)
	hurtbox.hurt.connect(_on_hurt.call_deferred)
	hitbox.hit.connect(_on_hit.call_deferred)

func _process(delta: float) -> void:
	if position.y <= -50: queue_free()
	if position.x <= -50 or position.x >= 1394: queue_free()
	var state = playback.get_current_node()
	match state:
		"ChaseState":
			translate(direction * speed * delta)
		"FlyAwayState":
			translate((direction + Vector2(0, -0.5)) * speed * delta)

func _on_hurt(other_hitbox: Hitbox) -> void:
	var feather_burst_effect = FEATHER_BURST_EFFECT.instantiate()
	get_tree().current_scene.add_child(feather_burst_effect)
	feather_burst_effect.global_position = sprite_2d.global_position
	game.kills += 1
	queue_free()

func _on_hit(other_hurtbox: Hurtbox) -> void:
	playback.travel("FlyAwayState")
