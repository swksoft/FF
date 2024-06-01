extends Node2D

@export var enemy_scene: PackedScene # La escena del enemigo que vamos a instanciar
@export var enemies_path : NodePath

var grid_positions = []

func _ready():
	# Inicializar las posiciones de la cuadrícula basadas en el viewport
	var vertical_divisions = 8
	var horizontal_divisions = 10 # Ajusta esto según el tamaño de tus enemigos
	var viewport_height = get_viewport().size.y / 2
	var viewport_width = get_viewport().size.x / 2

	for i in range(horizontal_divisions):
		for j in range(vertical_divisions):
			var x_position = i * (viewport_width / horizontal_divisions)
			var y_position = j * (viewport_height / vertical_divisions)
			grid_positions.append(Vector2(x_position, y_position))

	# Llamar al patrón de spawn deseado
	#spawn_random_enemy()
	#spawn_circle_pattern()
	spawn_at_grid_position(0, -60)
	spawn_at_grid_position(0, -40)
	spawn_at_grid_position(0, -20)
	spawn_at_grid_position(0, -10)
	#spawn_at_grid_position(-5, -38.3)
	#spawn_at_grid_position(-6, -37.4)

func spawn_enemy(position: Vector2):
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_node(enemies_path).add_child(enemy)

func spawn_random_enemy():
	var random_index = randi() % grid_positions.size()
	print(random_index)
	spawn_enemy(grid_positions[random_index])

func spawn_circle_pattern():
	# Definir las posiciones relativas para el patrón circular
	var circle_pattern = [
		Vector2(1, -60),
		Vector2(0, -40),
		Vector2(0, -20),
		Vector2(0, 0),
		Vector2(0, 20),
		Vector2(0, 40),
		Vector2(0, 60)
	]
	
	var base_position = grid_positions[34] # Posición central en la cuadrícula

	for offset in circle_pattern:
		var spawn_position = base_position + Vector2(0, offset.y)
		if spawn_position.y >= 0 and spawn_position.y < get_viewport().size.y:
			spawn_enemy(spawn_position)

func spawn_at_grid_position(grid_x: int, grid_y: int):
	var index = grid_x * 8 + grid_y # Asumiendo 8 divisiones verticales
	if index < grid_positions.size():
		spawn_enemy(grid_positions[index])
