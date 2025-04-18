extends Resource
class_name StatBonusResource

#@export_enum("health", "defense", "speed", "damage", "stamina", "cooldown", "accuracy", "crits") var stat_selected: int
#@export var bonus_value : int
@export var bonus_stat : Dictionary = {
	"health" : 0,
	"defense" : 0,
	"speed" : 0,
	"damage" : 0,
	"stamina" : 0,
	"cooldown" : 0,
	"accuracy" : 0,
	"crits" : 0,
}
