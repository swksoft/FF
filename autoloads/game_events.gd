extends Node

signal player_turn_start
signal enemy_turn_start
signal pause_start
signal update_data_hud
signal update_money_hud
signal update_turn_hud
signal update_troop

@export_category("General Data")
@export var current_money : int = 500
@export var current_turn : int = 0

@export_category("Troops")
@export_range(0,99) var shield_troops : int = 0
@export_range(0,99) var homing_troops : int = 0
@export_range(0,99) var shoot_troops : int = 0
@export_range(0,99) var bomb_troops : int = 0
@export_range(0,99) var laser_troops : int = 0

var types_troop = [shoot_troops, laser_troops, homing_troops, bomb_troops, shield_troops]
var total_troops : int = types_troop[0] + types_troop[1] + types_troop[2] + types_troop[3] + types_troop[4]

func emit_player_turn_start():
	player_turn_start.emit()
	
func emit_enemy_turn_start():
	enemy_turn_start.emit()
	
func emit_pause_start():
	pause_start.emit()

func emit_update_troop():
	update_troop.emit()
