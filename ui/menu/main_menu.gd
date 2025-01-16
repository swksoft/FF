extends Control

@onready var start_button = $PanelContainer/VBoxContainer/NewGame
@onready var exit_button = $PanelContainer/VBoxContainer/Exit

func _ready():
	GameEvents.current_turn = 0
	
	start_button.grab_focus()
	
	match OS.get_name():
		"Windows":
			pass
		"macOS":
			pass
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			pass
		"Android":
			exit_button.disabled = true
		"iOS":
			exit_button.disabled = true
		"Web":
			exit_button.disabled = true

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://levels/main_scene.tscn")
	GameEvents.reset_data()

func _on_exit_pressed():
	get_tree().quit()
