extends CharacterBody2D
class_name Enemy

@export var speed : int = 160
@export var direction = Vector2.LEFT.normalized()
@export var money_get = 5
@export var randomized : bool = true
@export var can_shoot : bool = true
@export var bullet_scene : PackedScene

func _ready():
	GameEvents.emit_enemy_spawn()
	
	randomize()
	
	if randomized == true:
		speed = randi_range(50, 250)

func _physics_process(delta):
	position += direction * speed * delta

func death():
	GameEvents.emit_enemy_death(money_get)
	queue_free()

func get_damage():
	GameEvents.current_money += money_get
	death()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		area.pierce += 1
		if area.pierce >= area.max_pierce: area.queue_free()
		get_damage()
		
	elif area.is_in_group("Troop"):
		get_damage()
		
	elif area.is_in_group("Explosion"):
		get_damage()
	
	elif area.is_in_group("EnemyWall"):
		death()

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = global_position
	bullet.set_collision_layer_value(2, true)
	bullet.direction = Vector2.LEFT
	
	get_parent().add_child(bullet)

func _on_timer_timeout():
	if can_shoot == true:
		shoot()

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	visible = false
