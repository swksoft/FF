extends Node

# NEW SIGNALS
signal take_action(who)
signal end_turn # TODO: CHECK IF PLAYER ACTIONS ARE DEPLETED

# MAP SIGNALS
signal player_turn_start
signal player_turn_end
signal action_taken
signal terrain_conquested(name_terrain)
signal update_general_data
signal update_troop
signal data_troup

# SHOOTER SIGNALS
signal update_data_shooter
signal enemy_death
signal player_death
signal time_out
signal player_escape

@export_enum("player", "enemy") var whos_turn : int = 0

@export_category("Territory Data")
@export var territories: Dictionary = {
	"bliblo": { "lives": 1, "is_conquered": false, "confronted": false },
	"subus": { "lives": 2, "is_conquered": false , "confronted": false},
	"new ocre": { "lives": 3, "is_conquered": false , "confronted": false},
	"aguascalientes": { "lives": 3, "is_conquered": false , "confronted": false},
	"ys": { "lives": 2, "is_conquered": false , "confronted": false}
}

@export_category("General Data")
@export var current_money : int = 1959
@export var current_turn : int = 0
@export var max_actions : int = 2
var actions : int

@export_category("Troops")
@export_range(0,99) var shield_troops : int = 1
@export_range(0,99) var homing_troops : int = 1
@export_range(0,99) var shoot_troops : int = 1
@export_range(0,99) var bomb_troops : int = 1
@export_range(0,99) var laser_troops : int = 1

var types_troop = [shoot_troops, laser_troops, homing_troops, bomb_troops, shield_troops]
var total_troops : int = types_troop[0] + types_troop[1] + types_troop[2] + types_troop[3] + types_troop[4]

var conquisted_territories : int

func emit_terrain_conquested(name_terrain):
	emit_signal("terrain_conquested", name_terrain)

func _ready():
	pass#reset_data() # TODO: COLOCAR EN BUILD

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

func emit_update_data_shooter():
	emit_signal("update_data_shooter")

func emit_data_troup():
	calculate_troops()
	emit_signal("data_troup")

func emit_player_turn_start():
	player_turn_start.emit()

func emit_update_general_data():
	update_general_data.emit()

func emit_action_taken():
	action_taken.emit()
	
func emit_player_turn_end():
	player_turn_end.emit()

func emit_update_troop():
	update_troop.emit()
