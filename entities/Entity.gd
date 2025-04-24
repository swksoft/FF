extends CharacterBody2D
class_name Entity

signal finish_turn

var turn_manager : Node = null

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
	
	turn_manager = get_parent().get_node_or_null("TurnManagerBattle")

func _on_entity_ready() -> void:
	turn_manager.turn_changed.connect(_on_turn_changed)

func _on_turn_changed(_turn_who, _number) -> void:
	stamina.stamina_change.emit(50)

func die():
	var death = stats.attribute.death_animation.instantiate()
	death.position = global_position
	get_parent().call_deferred("add_child", death)
	
	queue_free()
