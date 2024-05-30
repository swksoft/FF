extends Enemy

@export var explosion_scene : PackedScene

func get_damage():
	var explosion = explosion_scene.instantiate()
	explosion.position = global_position
	get_parent().call_deferred("add_child", explosion)

func _on_explosion_time_timeout():
	get_damage()
