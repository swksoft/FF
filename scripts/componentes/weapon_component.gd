extends BaseComponent
class_name WeaponComponent

@export var collision_layer : int
@export var direction_bullet : Vector2
@export var available_weapons : Array[WeaponResource] = []

var weapon_state = 0

@onready var weapon: Weapon = $Weapon

func _setup() -> void:
	await get_tree().process_frame
	
	if available_weapons == null or available_weapons == []:
		push_error("No se encontraron armas")
		return
	load_weapon(weapon_state)
		
	is_ready = true

func switch_weapon(advance: int) -> void:
	weapon_state = (weapon_state + advance) % available_weapons.size()
	
	if weapon_state < 0:
		weapon_state += available_weapons.size()
	
	load_weapon(weapon_state)

func load_weapon(index: int) -> void:
	var weapon_resource = available_weapons[index]
	
	weapon.weapon_stat = available_weapons[weapon_state]
	weapon.collision_layer = collision_layer
	weapon.direction = direction_bullet
