class_name Game extends Resource

var kills: = 0 :
	set(value):
		var previous_kills = kills
		kills = value
		if kills != previous_kills: 
			kills_changed.emit()

signal kills_changed()
