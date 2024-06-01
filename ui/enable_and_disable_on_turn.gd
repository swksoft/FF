extends Node

var button : Control

func _ready():
	button = get_parent()
	#GameEvents.player_turn_start.connect(on_turn_start)
	#GameEvents.player_turn_end.connect(on_turn_end)
	
func on_turn_start():
	button.mouse_filter = Control.MOUSE_FILTER_STOP
	if button is Button:
		button.disabled = false

func on_turn_end():
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if button is Button:
		button.disabled = true
