extends CharacterBody2D
class_name Enemy

@export var money_get = 5
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

func _ready():
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo Player")
		return
	
	GameEvents.emit_enemy_spawn()
	GameEvents.stats_loaded.connect(on_stats_loaded)
	
	randomize()
	
	if randomized == true:
		stats.attribute.speed = randi_range(50, 250)

func on_stats_loaded():
	name = stats.attribute.name_character
	
	$CooldownShootTimer.wait_time = stats.attribute.shoot_cooldown
	$Sprite.texture = stats.attribute.sprite

func _physics_process(delta):
	position += direction * stats.attribute.speed * delta

#func shoot():
	#var bullet = bullet_scene.instantiate()
	#
	#bullet.position = global_position
	#bullet.set_collision_layer_value(2, true)
	#bullet.direction = Vector2.LEFT
	#bullet.name = "BulletEnemy"
	#get_parent().add_child(bullet, true)

func _on_timer_timeout():
	if can_shoot == true:
		pass
		#shoot()

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	visible = false

func die():
	GameEvents.emit_enemy_death(stats.attribute.money_get)
	
	var death = stats.attribute.death_animation.instantiate()
	death.position = global_position
	get_parent().call_deferred("add_child", death)
	
	queue_free()
