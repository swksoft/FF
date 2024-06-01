extends Node

signal time_passed_hud(current_time)
signal update_hud(money_get, total_enemies)

@export var money_get : int = 0
@export var countdown_time : float = 120.0
@export var timer_on : bool = false

var current_time: float
var total_enemies : int = 0

var battle_type: String
var battle_territory: String

func _ready():
	GameEvents.time_out.connect(_on_time_out)
	GameEvents.enemy_spawn.connect(_on_enemy_spawn)
	GameEvents.enemy_death.connect(_on_enemy_death)
	
	var screen_size = get_viewport().size
	
	GameEvents.in_battle = true
	
	Input.warp_mouse(Vector2(0, screen_size.y/2))
	
	current_time = countdown_time

func _process(delta):
	if timer_on == false:
		return
	
	if current_time > 0:
		current_time -= delta
		emit_signal("time_passed_hud", str(round(current_time)))
		
		if current_time <= 0.1:
			current_time = 0
			GameEvents.emit_time_out()

func _on_battle_start(type: String, territory: String):
	GameEvents.start_battle(type, territory)

func _on_battle_end(result: String):
	GameEvents.current_money = money_get
	GameEvents.end_battle(result)
	#get_tree().change_scene_to_file("res://levels/main_scene.tscn")
	get_tree().call_deferred("change_scene_to_file", "res://levels/main_scene.tscn")
	
func _on_time_out():
	_on_battle_end("ganado")

func _on_player_control_escape_signal():
	money_get = 0
	_on_battle_end("escapado")
	
func _on_enemy_spawn():
	total_enemies += 1
	emit_signal("update_hud", money_get, total_enemies)

func _on_enemy_death(money : int):
	money_get += money
	#total_enemies -= 1
	
	if total_enemies <= 0:
		_on_battle_end("ganado")
		
	emit_signal("update_hud", money_get, total_enemies)

func _on_player_player_death():
	get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")


func _on_snake_boss_end_level():
	_on_battle_end("gamado")

func _on_pointy_boss_end_level():
	_on_battle_end("gamado")

func _on_giant_boss_end_level():
	_on_battle_end("gamado")

func _on_snake_boss_get_money(price):
	money_get += price

func _on_pointy_boss_get_money(price):
	money_get += price

func _on_giant_boss_get_money(price):
	money_get += price
