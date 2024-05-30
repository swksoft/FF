extends Enemy

var orbitRadius = 5  # Radio de la órbita
var angularSpeed = 1  # Velocidad angular de la órbita

func _process(delta):
	translate(Vector3.FORWARD * speed * delta)
	
	rotate(angularSpeed * delta)
	
	# Actualiza la posición relativa al punto de órbita
	var orbit_center = $OrbitCenter.global_transform.origin
	#global_transform.origin = orbit_center + Vector3(orbitRadius, 0, 0).rotated(Vector3.UP, global_transform.basis.yaw())
