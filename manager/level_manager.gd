extends Node

# TODO: DONT FORGET ABOUT MAX TROUPS0

signal time_passed_hud(current_time)
signal update_hud(money_get, total_enemies)

@export var money_get : int = 0
@export var countdown_time : float = 120.0
@export var timer_on : bool = false

var current_time: float
var total_enemies : int = 0

func _process(delta):
	# USE THIS ONLY ON DEFENSE
	if timer_on == false:
		return
	
	if current_time > 0:
		current_time -= delta
		emit_signal("time_passed_hud", str(round(current_time)))
		if current_time <= 0.1:
			current_time = 0
			print("Countdown finished! (failed to conquest)")

func game_over():
	get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")

func _ready():
	GameEvents.in_battle = true
	
	GameEvents.enemy_spawn.connect(_on_enemy_spawn)
	GameEvents.enemy_death.connect(_on_enemy_death)
	
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
