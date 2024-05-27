extends CharacterBody2D
class_name Enemy

@export var speed = 160
@export var direction = Vector2.LEFT
@export var money_get = 15

func _physics_process(delta):
	position += direction * speed * delta

func get_damage():
	GameEvents.current_money
	queue_free()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		get_damage()
	area.queue_free()

