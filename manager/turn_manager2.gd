class_name TurnManager extends Node

signal hide_hud(activate)

@export var territory_manager : TerritoryManager
@export var counter_screen_scene : PackedScene

func _ready():
	GameEvents.fight.connect(_on_fight)
	GameEvents.defend.connect(_on_defend)
	
	#if GameEvents.in_battle:
		#GameEvents.in_battle = false
		#
	if GameEvents.in_battle:
		handle_return_from_battle()
		GameEvents.reset_battle_state()
		
	if GameEvents.current_turn == 0:
		next_turn()

func handle_return_from_battle():
	if GameEvents.battle_type == "ataque":
		print("El jugador vuelve de una batalla de ataque")
	elif GameEvents.battle_type == "defensa":
		print("El jugador vuelve de una batalla de defensa")

	match GameEvents.battle_result:
		"ganado":
			print("El jugador ganó la batalla")
		"perdido":
			print("El jugador perdió la batalla")
		"escapado":
			print("El jugador escapó de la batalla")

func start_attack_battle(territory: String):
	GameEvents.territories[territory]["confronted"] = true
	GameEvents.start_battle("ataque", territory)
	
	get_tree().change_scene_to_file("res://levels/attack/map_attack.tscn")
	#get_tree().call_deferred("change_scene_to_file", "res://levels/attack/map_attack.tscn")

func start_defense_battle(territory: String):
	GameEvents.start_battle("defensa", territory)
	get_tree().change_scene_to_file("res://levels/defend/map_defend_2.tscn")

func all_territories_conquered() -> bool:
	for territory in GameEvents.territories.values():
		if not territory["is_conquered"]:
			return false
	return true

func check():
	if all_territories_conquered():
		get_tree().change_scene_to_file("res://ui/win_screen.tscn")

func next_turn():
	check()
	
	if GameEvents.whos_turn == 0:
		GameEvents.whos_turn = 1
		enemy_turn()
	elif GameEvents.whos_turn == 1:
		GameEvents.whos_turn = 0
		
		GameEvents.current_turn += 1
		GameEvents.current_money += get_money()
		
		player_turn()

func get_money():
	var base_income = 972
	var income = base_income
	
	for territory in GameEvents.territories.values():
		if territory["is_conquered"]:
			income += base_income * 0.25
	return round(income)

func player_turn():
	emit_signal("hide_hud", false)

func enemy_turn():
	emit_signal("hide_hud", true)
	var current_enemies = territory_manager.counterattack()
	for enemy in current_enemies.size():
		var counter_screen = counter_screen_scene.instantiate()
		counter_screen.territory = current_enemies[enemy]
		add_child(counter_screen)

func _on_endturn_pressed(): next_turn()

func _on_fight(territory):
	start_attack_battle(territory)

func _on_defend(territory):
	start_defense_battle(territory)
