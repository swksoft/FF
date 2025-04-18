extends Area2D
class_name HurtBox

signal hit_detected(damage: int)

@export var knockback_force : float
@export var freeze := false

@onready var sfx : AudioStreamPlayer = $AudioStreamPlayer

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0

func _on_area_entered(area: Node2D):
	emit_signal("hit_detected", area.damage)
	
	var camera = get_parent().get_parent().get_node("CameraEvent")
	var audio = get_parent().stats.attribute.dmg_sfx
	
	if freeze:
		frameFreeze(0.15, 0.5)
	
	if sfx != null:
		sfx.stream = audio
		sfx.play()
	
	if camera != null:
		camera.apply_shake()
	
	if area.has_method("on_hit"):
		area.on_hit(self)
