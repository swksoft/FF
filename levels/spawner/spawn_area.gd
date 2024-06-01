extends Node2D

@export var timer_on = false

@export var spawn_node : NodePath

@onready var point_1 = $Point1
@onready var point_2 = $Point2
@onready var point_3 = $Point3
@onready var point_4 = $Point4
@onready var point_5 = $Point5

var areas = []

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

@onready var timer_short = $TimerShort
@onready var timer_medium = $TimerMedium
@onready var timer_long = $TimerLong

func randomize_timers():
	if timer_on == true:
		timer_long.wait_time = randf_range(1,3)
		timer_medium.wait_time = randf_range(5,8)
		timer_short.wait_time = randf_range(10,13)
		timer_long.start()
		timer_medium.start()
		timer_short.start()

func _ready():
	areas = [point_1, point_2, point_3, point_4, point_5]
	
	randomize()
	randomize_timers()
	
	spawn()

func spawn():
	var selected_sceme = scenes[randi() % scenes.size()].instantiate()
	var selected_area = areas[randi() % areas.size()]
	
	selected_sceme.position = selected_area.global_position
	
	get_node(spawn_node).add_child(selected_sceme)

func _on_timer_short_timeout():
	randomize_timers()
	spawn()

func _on_timer_medium_timeout():
	randomize_timers()
	spawn()

func _on_timer_long_timeout():
	randomize_timers()
	spawn()
