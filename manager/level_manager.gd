extends Node

# TODO: DONT FORGET ABOUT MAX TROUPS

@export var money_get : int = 0
@export var time : float = 120.0
@export var total_enemies : int

func game_over():
	get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")

func _ready():
	GameEvents.emit_update_data_shooter()

func on_kill_get(value):
	money_get += value

func on_battle_finished():
	GameEvents.current_money += money_get

func on_battle_canceled():
	money_get = 0
	GameEvents.current_money += money_get

func battle_end():
	get_tree().change_scene_to_file("res://levels/main_scene.tscn")

func _on_player_control_escape_signal():
	money_get = 0
	

func _on_player_player_death():
	game_over()
