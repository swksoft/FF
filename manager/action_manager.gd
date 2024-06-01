class_name ActionManager extends Node

signal change_hud_turns
signal fight_selected

func recover_actions():
	GameEvents.actions = GameEvents.max_actions

func _ready():
	GameEvents.action_taken.connect(_on_action_taken)

func _on_action_taken():
	GameEvents.actions -= 1
	
	emit_signal("change_hud_turns")

func _on_endturn_pressed():
	recover_actions()
	GameEvents.emit_update_general_data()
