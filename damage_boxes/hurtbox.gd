class_name Hurtbox extends Area2D

@export var is_invincible: = false

signal hurt(hitbox: Hitbox) 

func take_hit(hitbox: Hitbox) -> void:
	if is_invincible: return
	hurt.emit(hitbox)
