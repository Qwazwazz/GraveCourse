extends Node2D

@export var direction: = Vector2.LEFT
@export var speed: = 75

@onready var anchor: Node2D = $Anchor
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

func _ready() -> void:
	var skeleton = get_tree().get_first_node_in_group("Skeleton") as CharacterBody2D
	direction.x = sign(skeleton.global_position.x - global_position.x)
	anchor.scale.x = sign(direction.x)
	pass

func _process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"ChaseState":
			translate(direction * speed * delta)
		"FlyAwayState":
			pass
