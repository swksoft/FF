extends CharacterBody2D
class_name Boss

signal end_level
signal get_money(price)

@export var price = 3200
@export var max_health = 500
var health

func _ready():
	health = max_health

func _physics_process(delta):
	print(health)
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		emit_signal("get_money", price)
		emit_signal("end_level")
		queue_free()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		take_damage(area.damage)
	area.queue_free()
