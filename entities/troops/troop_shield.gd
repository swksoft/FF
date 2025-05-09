extends Troop

var life = 2
var orbit_angle = 0.0

@export var orbit_radius = 45  # Radio de la órbita alrededor del mouse
@export var orbit_speed = 2 * PI  # Velocidad angular de la órbita (radianes por segundo)

func get_damage():
	life -= 1
	if life <= 0:
		queue_free()

func randomize_stats():
	orbit_angle = randf_range(0.0, 180)
	orbit_speed = randf_range(0.5, 2.5) * PI
