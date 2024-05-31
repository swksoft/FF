extends Control

@onready var record_label = $C/V/RecordLabel

func _ready():
	record_label.text = "Your Record: " + str(GameEvents.current_turn) + " turns"
	GameEvents.whos_turn = 1

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
