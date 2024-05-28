extends CanvasModulate



func _ready():
	GameEvents.player_turn_start.connect(on_turn_start)
	GameEvents.player_turn_end.connect(on_turn_end)
	
func reset():
	color.a = 1
	
func on_turn_start():
	reset()
	
func on_turn_end():
	color.a = 0.5
