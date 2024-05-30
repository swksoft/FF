extends Enemy

var has_entered_screen = false

func _physics_process(delta):
	if not has_entered_screen:
		if position.x >= 0 and position.x <= 640 and position.y >= 0 and position.y <= 360:
			has_entered_screen = true
			
	if has_entered_screen:
		# Calcular la nueva posición
		var new_position = position + direction * speed * delta

		if new_position.x <= 0 or new_position.x >= 640:
			direction.x = -direction.x  # Invertir la dirección en el eje X
		if new_position.y <= 0 or new_position.y >= 360:
			direction.y = -direction.y  # Invertir la dirección en el eje Y

	# Aplicar el movimiento
	position += direction * speed * delta
