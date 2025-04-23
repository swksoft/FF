extends Entity
class_name Enemy

@export var randomized : bool = true
@export var can_shoot : bool = true

var can_move : bool
var direction = Vector2.LEFT.normalized()
var invulnerabilty : bool = false

@onready var hitbox: HitboxComponent = $Hitbox
@onready var cooldown_shoot: Timer = $CooldownShootTimer

func _on_entity_ready():
	GameEvents.emit_enemy_spawn()
	
	name = stats.attribute.name_character
	$Sprite.texture = stats.attribute.sprite
	
	hitbox.damage = stats.attribute.base_damage_max
	
	cooldown_shoot.wait_time = weapon.available_weapons[0].cooldown_shoot
	cooldown_shoot.start()
	
	if randomized:
		randomize()
		stats.attribute.speed_max += randi_range(-250, 250)
	
	super._on_entity_ready()
	
	_on_turn_changed(turn_manager.turn_who, turn_manager.current_turn)

func _physics_process(delta):
	if not is_physics_processing():
		return
	
	if stamina.current_stamina > 0:
		stamina.stamina_drop.emit(1)
		position += direction * (stats.attribute.speed_max * delta)

func _on_timer_timeout():
	if can_shoot == true and stamina.current_stamina > 0:
		weapon.weapon.shoot()

func die():
	GameEvents.emit_enemy_death(stats.attribute.money_get)
	turn_manager.update_entity_count("enemy", -1)
	super.die()

func _on_turn_changed(_turn_who, _number) -> void:
	var condition = (_turn_who == 1)
	
	set_physics_process(condition)
	
	cooldown_shoot.paused = !condition

func _on_finish_turn() -> void:
	print("TURNO FINALIZADO")
