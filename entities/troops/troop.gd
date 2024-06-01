extends Player
class_name Troop

# TODO: RANDOMIZAR TIEMPO DE PROYECTIL EN PANTAYA (O CAMBIAR)

@export_enum("shield_troop", "homing_troops", "shoot_troops", "bomb_troops", "laser_troops") var type : int = 0

func get_damage():
	GameEvents.emit_troop_down(type)
	queue_free()

func shoot():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = global_position
	bullet.scale /= 2
	bullet.trail_lenght = 2
	bullet.set_collision_layer_value(3, true)
	
	get_parent().add_child(bullet)
