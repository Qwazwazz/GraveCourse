extends CharacterBody2D

@export var can_combo: = false

@onready var anchor: Node2D = $Anchor
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

var input_x: = 0.0
var last_input_x: = 1.0

func _physics_process(delta: float) -> void:
	var state: String = playback.get_current_node()
	match state:
		"MoveState":
			input_x = Input.get_axis("move_left", "move_right")
			if input_x != 0.0:
				last_input_x = input_x
				anchor.scale.x = sign(input_x)
			if Input.is_action_just_pressed("roll"):
				playback.travel("RollState")
			if Input.is_action_just_pressed("attack"):
				playback.travel("SwipeState")
			velocity.x = input_x * 100
			move_and_slide()
		"RollState":
			velocity.x = last_input_x * 175
			move_and_slide()
		"SwipeState":
			if Input.is_action_just_pressed("attack") and can_combo:
				playback.travel("SlashState")
			pass
		"SlashState":
			if Input.is_action_just_pressed("attack") and can_combo:
				playback.travel("StabState")
			pass
		"StabState":
			pass
