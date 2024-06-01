extends State
class_name SpawnEnemies

@export var boss : CharacterBody2D

var BASIC_ENEMY = preload("res://entities/enemy/basic_enemy.tscn")
var BOMB_ENEMY = preload("res://entities/enemy/bomb_enemy.tscn")
var DVD_ENEMY = preload("res://entities/enemy/dvd_enemy.tscn")
var FOLLOW_ENEMY = preload("res://entities/enemy/follow_enemy.tscn")
var SHIELD_ENEMY = preload("res://entities/enemy/shield_enemy.tscn")
var LINE_FORMATION_A = preload("res://entities/enemy/formations/line_formation_A.tscn")
var LINE_FORMATION_B = preload("res://entities/enemy/formations/line_formation_b.tscn")
var LINE_FORMATION_C = preload("res://entities/enemy/formations/line_formation_c.tscn")
var FORMATION_A = preload("res://entities/enemy/formations/formationA.tscn")
var FORMATION_B = preload("res://entities/enemy/formations/formationB.tscn")
var FORMATION_C = preload("res://entities/enemy/formations/formationC.tscn")

var scenes = [BASIC_ENEMY,
BOMB_ENEMY,
DVD_ENEMY,
FOLLOW_ENEMY,
SHIELD_ENEMY,
LINE_FORMATION_A,
LINE_FORMATION_B,
LINE_FORMATION_C,
FORMATION_A,
FORMATION_B,
FORMATION_C]

func Enter():
	var offset = Vector2(0, randi_range(-200,200))
	var selected_sceme = scenes[randi() % scenes.size()].instantiate()
	
	selected_sceme.position = boss.global_position + offset
	
	add_child(selected_sceme)

func Update(delta: float):
	Transitioned.emit(self, "idle")
