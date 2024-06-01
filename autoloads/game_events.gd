extends Node

# NEW SIGNALS
signal end_turn
signal fight(terrain)
signal defend
signal life_down()
signal life_up()
signal terrain_lives_hud

# MAP SIGNALS
signal action_taken
signal terrain_conquested(name_terrain)
signal update_general_data
signal update_troop
signal data_troup

# SHOOTER SIGNALS
signal enemy_death(money)
signal enemy_spawn
signal time_out
signal troop_down
signal player_escape

@export_enum("player", "enemy") var whos_turn : int = 1

@export_category("Territory Data")
@export var territories: Dictionary = {
	"bliblo": { "lives": 1, "is_conquered": false, "confronted": false },
	"subus": { "lives": 2, "is_conquered": false , "confronted": false},
	"new ocre": { "lives": 3, "is_conquered": false , "confronted": false},
	"aguascalientes": { "lives": 3, "is_conquered": false , "confronted": true},  # HACK: ( PERDON XD)
	"ys": { "lives": 2, "is_conquered": false , "confronted": false}
}

@export_category("General Data")
@export var current_money : int = 25
@export var current_turn : int = 0
@export var max_actions : int = 2
var actions : int

@export var player_lives = 3

var in_battle: bool = false
var battle_type: String = ""
var battle_result: String = ""
var current_territory: String = ""

var counter_attack_data = {}

@export_category("Troops")
@export_range(0,99) var shield_troops : int = 8
@export_range(0,99) var homing_troops : int = 0
@export_range(0,99) var shoot_troops : int = 0
@export_range(0,99) var bomb_troops : int = 0
@export_range(0,99) var laser_troops : int = 0

var types_troop = [shoot_troops, laser_troops, homing_troops, bomb_troops, shield_troops]
var total_troops : int = types_troop[0] + types_troop[1] + types_troop[2] + types_troop[3] + types_troop[4]

var conquisted_territories : int

func start_battle(type: String, territory: String):
	in_battle = true
	battle_type = type
	battle_result = ""
	current_territory = territory

func end_battle(result: String):
	battle_result = result
	update_territory_status()

func emit_life_up():
	life_up.emit()
	
func emit_life_down():
	life_down.emit()

func reset_battle_state():
	in_battle = false
	battle_type = ""
	battle_result = ""
	current_territory = ""

func update_territory_status():
	if current_territory in territories:
		var territory = territories[current_territory]

		if battle_result == "ganado" and battle_type == "ataque":
			territory["lives"] -= 1
			emit_terrain_lives_hud()
			if territory["lives"] <= 0:
				territory["is_conquered"] = true

		elif battle_result == "perdido" and battle_type == "defensa":
			territory["lives"] += 1
			emit_terrain_lives_hud()

		elif battle_result == "escapado":
			actions = 0

		territories[current_territory] = territory

func get_total_troops():
	return GameEvents.types_troop[0] + GameEvents.types_troop[1] + GameEvents.types_troop[2] + GameEvents.types_troop[3] + GameEvents.types_troop[4]

func _ready():
	actions = max_actions
	reset_data() # TODO: COLOCAR EN BUILD

func reset_data():
	territories = {
		"bliblo": { "lives": 1, "is_conquered": false, "confronted": false },
		"subus": { "lives": 2, "is_conquered": false , "confronted": false},
		"new ocre": { "lives": 3, "is_conquered": false , "confronted": false},
		"aguascalientes": { "lives": 3, "is_conquered": false , "confronted": true},
		"ys": { "lives": 2, "is_conquered": false , "confronted": false}
	}
	
	
	conquisted_territories = 0
	# TODO: LO DE ABAJO ESTA MAL CAMBIAR POR TYPES TROOP
	current_turn = 0
	actions = 2
	current_money = 959
	#shield_troops  = 0
	#homing_troops  = 0
	#shoot_troops = 0
	#bomb_troops = 0
	#laser_troops = 0
	in_battle = false

func emit_terrain_conquested(name_terrain):
	emit_signal("terrain_conquested", name_terrain)

func emit_troop_down(type):
	emit_signal("troop_down", type)

func emit_data_troup():
	data_troup.emit()

func emit_update_general_data():
	update_general_data.emit()

func emit_action_taken():
	action_taken.emit()

func emit_fight(terrain):
	emit_signal("fight", terrain)

func emit_defend(territory):
	emit_signal("defend", territory)

func emit_enemy_death(money):
	emit_signal("enemy_death", money)
	
func emit_enemy_spawn():
	enemy_spawn.emit()

func emit_time_out():
	time_out.emit()

func emit_terrain_lives_hud():
	terrain_lives_hud.emit()
