extends State
class_name EnemyShootPlayer

@export var boss : CharacterBody2D
@export var bullet_scene : PackedScene
@export var cooldown := 1

var player : CharacterBody2D
var can_shoot = true
var max_bullets := 3

@onready var cooldown_timer = $CooldownTimer

func Enter():
	max_bullets = 3
	cooldown_timer.wait_time = cooldown
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	print(cooldown_timer.wait_time)
	
	if max_bullets >= 0:
		Transitioned.emit(self, "movepong")
	
	if can_shoot:
		can_shoot = false
		cooldown_timer.start()
		
		var bullet = bullet_scene.instantiate()
		
		bullet.position = boss.global_position
		bullet.set_collision_layer_value(2, true)
		bullet.scale *= 2
		bullet.speed = boss.projectile_velocity
		bullet.time_despawn = 4
		bullet.direction = (player.global_position - boss.global_position).normalized()
		bullet.set_collision_layer_value(2, true)
		bullet.max_pierce = 2
		
		add_child(bullet)
		
		max_bullets -= 1

func _on_cooldown_timer_timeout():
	print("hola")
	can_shoot = true
