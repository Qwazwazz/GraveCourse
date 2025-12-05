class_name UnitMover extends Node

@export var unit: CharacterBody2D
@export var flip_node: Node2D
@export var default_friction: = 750.0
@export var hit_friction: = 250.0

func apply_friction(delta: float, amount: float = default_friction) -> void:
	unit.velocity.x = move_toward(unit.velocity.x, 0.0, amount * delta)

func apply_knockback(other_hitbox: Hitbox) -> void:
	var knockback_direction = sign(unit.global_position.x - other_hitbox.global_position.x)
	unit.velocity.x = knockback_direction * other_hitbox.knockback_amount

func apply_flip(input_x: float) -> void:
	flip_node.scale.x = sign(input_x)
