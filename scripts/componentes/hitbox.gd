extends Area2D
class_name HitboxComponent

@export var damage: float

func on_hit(area):
	#print("QUE ES ESTO: ", area.name)
	#print("DAMAGE: ", damage)
	DamageNumbers.display_number(damage, global_position + Vector2(0, -18))
