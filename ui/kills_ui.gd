extends HBoxContainer

var game: Game = load("res://game.tres")

@onready var kills_value: Label = $KillsValue


func _ready() -> void:
	game.kills_changed.connect(func():
		kills_value.text = str(game.kills)
	)
