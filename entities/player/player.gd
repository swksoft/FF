extends CharacterBody2D

@export var bullet_scene : PackedScene

@export var speed = 500
@export var max_speed = 1250

@export var acceleration = 8000
@export var deceleration = 1
@export var stop_distance = 5
@export var slow_down_distance = 50

@export var cooldown : float = 0.5

var direction = Vector2.ZERO
var mouse_position = null

@onready var cooldown_shoot = $CooldownShoot

# TODO: QUE NO SEA POSIBLE MOVER AL PERSONAJE FUERA DE LA PANTALLA (si sacas el mouse de la ventana el personaje te sigue hasta ahí)

func _ready():
	cooldown_shoot.wait_time = cooldown

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
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

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = global_position
	
	get_parent().add_child(bullet)

func _on_cooldown_shoot_timeout():
	shoot()
