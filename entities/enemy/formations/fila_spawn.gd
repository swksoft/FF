extends Node2D

@export var quantity : int = 0
@export var type : Array = [preload("res://entities/enemy/basic_enemy.tscn"), preload("res://entities/enemy/bomb_enemy.tscn"), preload("res://entities/enemy/dvd_enemy.tscn"), preload("res://entities/enemy/follow_enemy.tscn"), preload("res://entities/enemy/shield_enemy.tscn")]
@export var selected_type = 0

const SCREEN_WIDTH = 640
const SCREEN_HEIGHT = 360

const GRID_SPACES = 8

func _ready():
	spawn_enemies()

func spawn_enemies():
	var space_height = SCREEN_HEIGHT / GRID_SPACES
	
	for i in range(quantity):
		var enemy_instance = type[selected_type].instantiate()
		
		# Posición Y aleatoria en la cuadrícula de 8 espacios
		var random_space = randi() % GRID_SPACES
		var y_position = random_space * space_height + (space_height / 2)
		
		# Asignar la posición en Y aleatoria
		enemy_instance.position.y = y_position
		
		# Añadir el enemigo como hijo del Spawner o de la escena principal
		#get_parent().add_child(enemy_instance)
		get_parent().add_child.call_deferred(enemy_instance)
		
