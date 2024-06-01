extends Enemy

@export var explosion_scene : PackedScene

func get_damage():
	var explosion = explosion_scene.instantiate()
	explosion.position = global_position
	get_parent().call_deferred("add_child", explosion)
	death()

func _on_explosion_time_timeout():
	pass
	#get_damage()

func _on_hurtbox_area_entered(_area):
	get_damage()
