extends HBoxContainer

var game: Game = load("res://game.tres")

@onready var kills_value: Label = $KillsValue


func _ready() -> void:
	update_kills_value()
	game.kills_changed.connect(update_kills_value)

func update_kills_value() -> void:
	kills_value.text = str(game.kills)
