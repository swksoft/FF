extends Area2D
class_name HurtBox

signal hit_detected(damage: int)
signal knockback(knockback_vector : Vector2)

@export var knockback_force : float

func _on_area_entered(area: Node2D):
	print_debug("hit by ", area.name)
	emit_signal("hit_detected", area.damage)
	
	if area.has_method("on_hit"):
		area.on_hit(self)
