extends CharacterBody2D
class_name Enemy

@export var randomized : bool = true
@export var can_shoot : bool = true
@export_category("imports")
@export var stats : StatsComponent
@export var weapon : WeaponComponent
@export var stamina : StaminaComponent
@export var health : HealthComponent

var can_move : bool
var direction = Vector2.LEFT.normalized()
var invulnerabilty : bool = false

@onready var hitbox: HitboxComponent = $Hitbox
@onready var cooldown_shoot: Timer = $CooldownShootTimer
@onready var turn_manager = get_tree().get_first_node_in_group("TurnManagerBattle")

func _ready():
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo Player")
		return
	
	GameEvents.emit_enemy_spawn()
	GameEvents.stats_loaded.connect(on_stats_loaded)
	
	turn_manager.turn_changed.connect(_on_turn_changed)
	hitbox.damage = stats.attribute.base_damage_max
	
	randomize()
	
	cooldown_shoot.wait_time = weapon.available_weapons[0].cooldown_shoot
	cooldown_shoot.start()
	
	if randomized == true:
		stats.attribute.speed_max += randi_range(-250, 250)

func on_stats_loaded():
	name = stats.attribute.name_character
	
	$CooldownShootTimer.wait_time = stats.attribute.shoot_cooldown
	$Sprite.texture = stats.attribute.sprite

func _physics_process(delta):
	if stamina.current_stamina > 0:
		stamina.stamina_drop.emit(1)
		position += direction * (stats.attribute.speed_max * delta)

func _on_timer_timeout():
	if can_shoot == true and stamina.current_stamina > 0:
		weapon.weapon.shoot()

func die():
	GameEvents.emit_enemy_death(stats.attribute.money_get)
	
	var death = stats.attribute.death_animation.instantiate()
	death.position = global_position
	get_parent().call_deferred("add_child", death)
	
	queue_free()

func _on_turn_changed(turn_who):
	print("AA")
	var condition = (turn_who == 1)
	
	set_process(condition)
	set_physics_process(condition)
	set_process_input(condition)
	cooldown_shoot.paused = !condition
	
