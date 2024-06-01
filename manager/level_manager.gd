extends Node

# TODO: DONT FORGET ABOUT MAX TROUPS 0

signal time_passed_hud(current_time)
signal update_hud(money_get, total_enemies)

@export var money_get : int = 0
@export var countdown_time : float = 120.0
@export var timer_on : bool = false

var current_time: float
var total_enemies : int = 0

var battle_type: String
var battle_territory: String

func _on_battle_start(type: String, territory: String):
	GameEvents.start_battle(type, territory)

func _on_battle_end(result: String):
	GameEvents.end_battle(result)
	get_tree().change_scene_to_file("res://levels/main_scene.tscn")

func _process(delta):
	if timer_on == false:
		return
	
	if current_time > 0:
		current_time -= delta
		emit_signal("time_passed_hud", str(round(current_time)))
		
		if current_time <= 0.1:
			current_time = 0
			GameEvents.emit_time_out()

func game_over():
	get_tree().call_deferred("change_scene_to_file", "res://ui/game_over_screen.tscn")

func _ready():
	# Imprimir los datos de la batalla (puedes quitar esto más tarde)
	
	var a = GameEvents.battle_type
	
	print("Tipo de batalla: ", GameEvents.battle_type)
	print("Territorio: ", GameEvents.current_territory)
	
	GameEvents.time_out.connect(_on_time_out)
	
	GameEvents.in_battle = true
	
	GameEvents.enemy_spawn.connect(_on_enemy_spawn)
	GameEvents.enemy_death.connect(_on_enemy_death)
	
	#_on_battle_start(type, territory)
	
	# TIME
	current_time = countdown_time
#
#func on_kill_get(value):
	#money_get += value
#
#func on_battle_finished():
	#GameEvents.current_money += money_get
#
#func on_battle_canceled():
	#money_get = 0
	#GameEvents.current_money += money_get

func _on_time_out():
	_on_battle_end("escape")

func battle_end():
	get_tree().call_deferred("change_scene_to_file", "res://levels/main_scene.tscn")

func _on_player_control_escape_signal():
	money_get = 0
	battle_end()
	
func _on_player_player_death():
	game_over()

func _on_enemy_spawn():
	total_enemies += 1
	emit_signal("update_hud", money_get, total_enemies)

func _on_enemy_death(money : int):
	money_get = money
	total_enemies -= 1
	
	if total_enemies <= 0:
		battle_end()
		
	emit_signal("update_hud", money_get, total_enemies)
