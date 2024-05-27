extends Node

# TODO: DONT FORGET ABOUT MAX TROUPS

@export var money_get : int = 0
@export var time : float = 120.0

func on_kill_get(value):
	money_get += value

func on_battle_finished():
	GameEvents.current_money += money_get

func on_battle_canceled():
	money_get = 0
	GameEvents.current_money += money_get

func _on_player_control_escape_signal():
	pass # Replace with function body.
	# TODO: ON BATTLE CANCELED SIGNAL
