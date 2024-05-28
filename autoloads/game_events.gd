extends Node

signal player_turn_start
signal player_turn_end
signal pause_start
signal action_taken
signal update_data_hud
signal update_general_data
signal update_money_hud
signal update_turn_hud
signal update_troop
signal data_troup

@export_category("General Data")
@export var current_money : int = 1959
@export var current_turn : int = 0
@export var max_actions : int = 2
var actions : int

@export_category("Troops")
@export_range(0,99) var shield_troops : int = 0
@export_range(0,99) var homing_troops : int = 0
@export_range(0,99) var shoot_troops : int = 0
@export_range(0,99) var bomb_troops : int = 0
@export_range(0,99) var laser_troops : int = 0

var types_troop = [shoot_troops, laser_troops, homing_troops, bomb_troops, shield_troops]
var total_troops : int = types_troop[0] + types_troop[1] + types_troop[2] + types_troop[3] + types_troop[4]

var conquisted_territories : int

func reset_data():
	conquisted_territories = 0
	# TODO: LO DE ABAJO ESTA MAL CAMBIAR POR TYPES TROOP
	current_turn = 0
	current_money = 1959
	shield_troops  = 0
	homing_troops  = 0
	shoot_troops = 0
	bomb_troops = 0
	laser_troops = 0

func calculate_troops():
	total_troops  = types_troop[0] + types_troop[1] + types_troop[2] + types_troop[3] + types_troop[4]

func recover_actions():
	actions = max_actions

func emit_data_troup():
	calculate_troops()
	emit_signal("data_troup")

func emit_player_turn_start():
	print("Player Turn")
	player_turn_start.emit()

func emit_update_general_data():
	print("General Data update")
	update_general_data.emit()

func emit_action_taken():
	action_taken.emit()
	
func emit_player_turn_end():
	print("Enemy Turn")
	player_turn_end.emit()
	
func emit_pause_start():
	pause_start.emit()

func emit_update_troop():
	update_troop.emit()
