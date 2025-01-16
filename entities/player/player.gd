extends CharacterBody2D
class_name Player

@export_category("imports")
@export var stats : StatsComponent
@export var weapon : WeaponComponent
@export var stamina : StaminaComponent
@export var health : HealthComponent
@export_group("advanced")
@export var offset : Vector2 = Vector2.ZERO
@export var curve : Curve

var can_shoot : bool = true
var can_move : bool = true
var mouse_position = null
var direction : Vector2
var invulnerabilty : bool = false
var death = false

@onready var particle: GPUParticles2D = $Particle
@onready var sprite: Sprite2D = $Sprite

func _enter_tree() -> void:
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo Player")
		return
	sprite.texture = stats.attribute.sprite
	particle.texture = stats.attribute.sprite

func _physics_process(_delta):
	if !death:
		if Input.is_action_just_pressed("restart") and OS.is_debug_build(): get_tree().reload_current_scene()
		if Input.is_action_just_pressed("right_click") and OS.is_debug_build(): stamina.stamina_recharge.emit(45)
		if Input.is_action_just_pressed("down"):
			#weapon_state = (weapon_state + 1) % available_weapons.size()
			weapon.switch_weapon(1)
		if Input.is_action_just_pressed("up"):
			#weapon_state = (weapon_state - 1) % available_weapons.size()
			weapon.switch_weapon(-1)
		
		$HurtboxPlayer/Col.disabled = invulnerabilty or death
		sprite.self_modulate = Color(1, 1, 1, 0.435) if invulnerabilty else Color(1, 1, 1, 1)
		particle.emitting = (direction != Vector2.ZERO and velocity != Vector2.ZERO)
		
		direction.x = Input.get_axis("left", "right")
		direction.y = Input.get_axis("up", "down")
		
		$InvalidLabel.visible = true if ((direction or Input.is_action_pressed("left_click")) and !can_move) else false
		
		if direction and can_move:
			stamina.stamina_drop.emit(1)
			velocity = direction * stats.attribute.speed_max
		else: velocity = velocity.move_toward(Vector2.ZERO, stats.attribute.speed_max)
		
		move_and_slide()
		
		if Input.is_action_pressed("left_click") and can_move: weapon.active_weapon.shoot()
		
func die():
	var death_animation = stats.attribute.death_animation.instantiate()
	
	death_animation.position = global_position
	
	get_parent().call_deferred("add_child", death_animation)
	$HurtboxPlayer/Col.call_deferred("set_disabled", true)
	
	death = true
	visible = false
