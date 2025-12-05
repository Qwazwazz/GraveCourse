class_name Skeleton extends CharacterBody2D

@export var run_speed: = 100.0
@export var roll_speed: = 175.0
@export var stats: Stats

@export var can_combo: = false

@onready var anchor: Node2D = $Anchor
@onready var unit_mover: UnitMover = $UnitMover
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hurtbox: Hurtbox = $Anchor/Hurtbox
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

var input_x: = 0.0
var last_input_x: = 1.0

func _ready() -> void:
	stats.no_health.connect(queue_free)
	hurtbox.hurt.connect(_on_hurt.call_deferred)

func _physics_process(delta: float) -> void:
	var state: String = playback.get_current_node()
	match state:
		"MoveState":
			input_x = Input.get_axis("move_left", "move_right")
			if input_x != 0.0:
				last_input_x = input_x
				unit_mover.apply_flip(input_x)
				velocity.x = input_x * run_speed
			else:
				unit_mover.apply_friction(delta)
				
			if Input.is_action_just_pressed("roll"):
				playback.travel("RollState")
			if Input.is_action_just_pressed("attack"):
				playback.travel("SwipeState")
			move_and_slide()
		"RollState":
			velocity.x = last_input_x * roll_speed
			move_and_slide()
		"SwipeState":
			unit_mover.apply_friction(delta)
			move_and_slide()
			if Input.is_action_just_pressed("attack") and can_combo:
				playback.travel("SlashState")
		"SlashState":
			unit_mover.apply_friction(delta)
			move_and_slide()
			if Input.is_action_just_pressed("attack") and can_combo:
				playback.travel("StabState")
		"StabState":
			unit_mover.apply_friction(delta)
			move_and_slide()
		"HitState":
			unit_mover.apply_friction(delta, unit_mover.hit_friction)
			move_and_slide()

func _on_hurt(other_hitbox: Hitbox) -> void:
	playback.start("HitState")
	stats.health -= other_hitbox.damage
	unit_mover.apply_knockback(other_hitbox)

func die() -> void:
	hide()
	set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
