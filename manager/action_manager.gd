extends Node

var action : int

func _ready():
	GameEvents.recover_actions()
	
func _on_action_taken():
	if action <= 0:
		print("cant")
		return
	action -= 1

func _on_endturn_pressed():
	GameEvents.recover_actions()
	GameEvents.emit_update_general_data()
