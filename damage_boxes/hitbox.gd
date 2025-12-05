class_name Hitbox extends Area2D

@export var damage: = 1.0
@export var knockback_amount: = 50.0

var already_hit_targets = []

signal hit(hurtbox: Hurtbox)

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func clear_already_hit_targets() -> void:
	already_hit_targets.clear()

func _on_area_entered(hurtbox: Area2D) -> void:
	if hurtbox is not Hurtbox: return
	if hurtbox in already_hit_targets: 
		return
	else:
		already_hit_targets.append(hurtbox)
	hurtbox = hurtbox as Hurtbox
	hurtbox.take_hit(self)
	hit.emit(hurtbox)
