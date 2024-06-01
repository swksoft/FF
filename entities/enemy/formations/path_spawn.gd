extends Node2D
class_name SpawnFormation

const SCREEN_WIDTH = 640
const SCREEN_HEIGHT = 360

@export var quantity : int = 18
@export var type : Array = [preload("res://entities/enemy/basic_enemy.tscn"), preload("res://entities/enemy/bomb_enemy.tscn"), preload("res://entities/enemy/dvd_enemy.tscn"), preload("res://entities/enemy/follow_enemy.tscn"), preload("res://entities/enemy/shield_enemy.tscn")]
@export var selected_type = 0

@onready var follow = $Path/Follow

func _ready():
	spawn_enemies()

func spawn_enemies():
	for i in range(quantity):
		var enemy_instance = type[selected_type].instantiate()
		
		follow.progress_ratio = randf()
		var spawn_position = follow.global_position
		
		enemy_instance.position = spawn_position
		
		get_parent().add_child.call_deferred(enemy_instance)
	
