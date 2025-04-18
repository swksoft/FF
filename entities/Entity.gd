extends CharacterBody2D
class_name Entity

@onready var stats : StatsComponent = $StatsComponent
@onready var health : HealthComponent = $HealthComponent
@onready var stamina : StaminaComponent = $StaminaComponent
@onready var weapon : WeaponComponent = $WeaponComponent

var is_ready : bool = false

func _ready() -> void:
	await _setup()
	is_ready = true
	_on_entity_ready()

func _setup() -> void:
	await stats._setup()
	await health._setup()
	await stamina._setup()
	await weapon._setup()

func _on_entity_ready() -> void:
	pass
