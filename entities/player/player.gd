extends CharacterBody2D
class_name Player

signal troop_down
signal player_death

# TODO: MAS TROPAS = MAS IMPRECISION

@export var bullet_scene : PackedScene

@export var speed = 500
@export var max_speed = 1250

@export var acceleration = 8000
@export var deceleration = 1
@export var stop_distance = 5
@export var slow_down_distance = 50
@export var offset : Vector2 = Vector2.ZERO
@export var can_shoot : bool = true

@export var cooldown : float = 1.5
@export var randomized : bool = false

var direction = Vector2.ZERO
var mouse_position = null

@onready var cooldown_shoot = $CooldownShoot

# FIXME: COLISIONES ROTAS

func get_damage():
	
	emit_signal("player_death")

func _ready():
	randomize()
	
	if randomized == true:
		randomize_stats()
		
	cooldown_shoot.wait_time = cooldown
	
	cooldown_shoot.start()

func randomize_stats():
	offset = Vector2(randi_range(-16,100), randi_range(-100,100))
	cooldown = randf_range(0.5, 2.0)
	
	speed = randi_range(300, 700)
	max_speed = randi_range(750, 1500)
	deceleration = randf_range(0.5, 1.5)
	acceleration = randi_range(5000, 12000)
	slow_down_distance = randi_range(50,150)
	stop_distance = randi_range(0.5,1.5)

func follow_mouse(_delta):
	mouse_position = get_global_mouse_position() + offset
	direction = (mouse_position - global_position).normalized()
	var distance_to_mouse = global_position.distance_to(mouse_position)
	
	if distance_to_mouse > stop_distance:
		if distance_to_mouse < slow_down_distance:
			var target_speed = max_speed * (distance_to_mouse / slow_down_distance)
			velocity = velocity.move_toward(direction * target_speed, acceleration)
		else:
			velocity += direction * acceleration
			velocity = velocity.limit_length(max_speed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration)
	
	move_and_slide()

func _physics_process(delta):
	follow_mouse(delta)

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = global_position
	bullet.set_collision_layer_value(3, true)
	
	get_parent().add_child(bullet)

func _on_cooldown_shoot_timeout():
	if can_shoot == true:
		shoot()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("Enemy") or area.is_in_group("EnemyBullet"):
		get_damage()
	if area.is_in_group("PlayerBullet"):
		get_damage()
