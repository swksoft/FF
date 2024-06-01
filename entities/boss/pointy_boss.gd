extends CharacterBody2D
class_name Boss

signal end_level
signal get_money(price)

@export var price = 3200
@export var max_health = 500
@export var projectile_velocity = 300
@export var territory_name : String

var health

@onready var sprite = $Sprite
@onready var anim = $AnimationPlayer
@onready var sfx_damage = $sfxDamage

func _ready():
	health = max_health

func _physics_process(delta):
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		GameEvents.territories[territory_name].lives -= 1
		emit_signal("get_money", price)
		emit_signal("end_level")
		queue_free()
	anim.play("take_damage")

	sfx_damage.play()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		take_damage(area.damage)
	elif area.is_in_group("Troops"):
		take_damage(area.damage)
	area.queue_free()
	

