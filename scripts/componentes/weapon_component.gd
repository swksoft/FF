extends Node
class_name WeaponComponent

signal shoot

@export var collision_layer : int
@export var direction : Vector2
@export var available_weapons : Array[WeaponResource] = []
@export var weapon_scene : PackedScene

var weapon_state = 0
var active_weapon : Weapon

func _ready() -> void:	
	if available_weapons == null or available_weapons == []:
		push_error("No se encontraron armas")
		return
	load_weapon(weapon_state)

func switch_weapon(direction: int) -> void:
	weapon_state = (weapon_state + direction) % available_weapons.size()
	
	if weapon_state < 0:
		weapon_state += available_weapons.size()
	
	load_weapon(weapon_state)

func load_weapon(index: int) -> void:
	if active_weapon != null:
		active_weapon.queue_free()
		active_weapon = null
	
	var weapon_resource = available_weapons[index]
	
	if weapon_resource is WeaponResource:
		active_weapon = weapon_scene.instantiate() as Weapon
		active_weapon.weapon_stat = available_weapons[weapon_state]
		#active_weapon = weapon_resource.instantiate()
		active_weapon.collision_layer = collision_layer
		active_weapon.direction = direction
		add_child(active_weapon, true)
	else:
		push_error("El recurso en available_weapons no es un PackedScene")
