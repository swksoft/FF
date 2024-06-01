extends Troop

@export var orbit_radius = 45  # Radio de la órbita alrededor del mouse
@export var orbit_speed = 2 * PI  # Velocidad angular de la órbita (radianes por segundo)
@export var bomb_scene : PackedScene

var life = 2
var orbit_angle = 0.0

func get_damage():
	var bomb = bomb_scene.instantiate()
	#get_parent().add_child(bomb)
	get_parent().call_deferred("add_child", bomb)
	
	queue_free()

func randomize_stats():
	orbit_radius = randi_range(80, 150)
	orbit_angle = randf_range(0.0, 180)
	orbit_speed = randf_range(0.1, 1.0) * PI

func follow_mouse(delta):
	mouse_position = get_global_mouse_position()
	
	orbit_angle -= orbit_speed * delta
	
	offset = Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_radius
	var target_position = mouse_position + offset
	
	global_position = target_position
