extends Resource
class_name CharacterStats

@export_category("obligatory_stats")
@export var name_character : String
@export var sprite : CompressedTexture2D
@export var death_animation : PackedScene

@export_category("gameplay_stats")
@export var health_max : float:
	get: return health_max
	set(value): health_max = clamp(value, 0, 9999)

@export var defense_max : float:
	get: return defense_max
	set(value): defense_max = clamp(value, 0, 9999)
	
@export var speed_max : float:
	get: return speed_max
	set(value): speed_max = clamp(value, 1, 255)

@export var base_damage_max : float:
	get: return base_damage_max
	set(value): base_damage_max = clamp(value, -999, 999)
	
@export var stamina_max : float:
	get: return stamina_max
	set(value): stamina_max = clamp(value, 0, 9999)

@export var stamina_charge : float
	
@export var shoot_cooldown_max : float:
	get: return shoot_cooldown_max
	set(value): shoot_cooldown_max = clamp(value, 0, 9999)

@export var accuracy_max : float:
	get: return accuracy_max
	set(value): accuracy_max = clamp(value, 0, 9999)

@export var crit_chance : float:
	get: return crit_chance
	set(value): crit_chance = clamp(value, 0, 999)

@export var bonus : StatBonusResource
