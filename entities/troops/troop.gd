extends Player
class_name Troop

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = global_position
	bullet.scale /= 2
	bullet.trail_lenght = 2
	
	get_parent().add_child(bullet)
