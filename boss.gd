extends CharacterBody2D

const HIT_BURST_PARTICLE = preload("res://effects/hit_burst_effect.tscn")

var game: Game = load("res://game.tres")

@export var walk_speed: = 30.0
@export var attack_range: = 150.0
@export var retreat_range: = 99.0
@export var stats: Stats

@onready var healthbar: ProgressBar = $Healthbar

@onready var hit_sound_effect: AudioStreamPlayer = $HitSoundEffect
@onready var skeleton_targeter: SkeletonTargeter = $SkeletonTargeter
@onready var hurtbox: Hurtbox = $Anchor/Hurtbox
@onready var hitbox: Hitbox = $Anchor/Hitbox
@onready var effect_marker_2d: Marker2D = $EffectMarker2D
@onready var unit_mover: UnitMover = $UnitMover
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

func _ready() -> void:
	stats = stats.duplicate()
	healthbar.stats = stats
	hurtbox.hurt.connect(_on_hurt.call_deferred)

func _physics_process(delta: float) -> void:
	if position.y <= -50: queue_free()
	if position.x <= -50 or position.x >= 1394: queue_free()
	
	var state = playback.get_current_node()
	match state:
		"ChaseState":
			var input_x: float = skeleton_targeter.get_direction_to_skeleton()
			if input_x != 0.0:
				unit_mover.apply_flip(input_x)
				velocity.x = input_x * walk_speed
			move_and_slide()
		"RetreatState":
			var input_x: float = -skeleton_targeter.get_direction_to_skeleton()
			if input_x != 0.0:
				unit_mover.apply_flip(-input_x)
				velocity.x = input_x * walk_speed
			move_and_slide()
		"DieState":
			pass
		"AttackState":
			pass

func die() -> void:
	queue_free()

func _on_hurt(other_hitbox: Hitbox) -> void:
	hit_sound_effect.play()
	var hit_burst_particle = HIT_BURST_PARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_burst_particle)
	var previous_health = stats.health
	hit_burst_particle.global_position = effect_marker_2d.global_position
	stats.health -= other_hitbox.damage
	unit_mover.apply_knockback(other_hitbox)
	
	if stats.health <= 0 and previous_health > 0: 
		game.kills += 1
		playback.travel("DieState")
