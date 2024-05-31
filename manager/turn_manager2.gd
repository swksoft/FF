class_name TurnManager extends Node

signal hide_hud(activate)



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

func _ready():
	
	if GameEvents.in_battle:
		print_debug(" RESULTADOS DE BATALLA : ")
		GameEvents.in_battle = false
	if GameEvents.current_turn == 0:
		next_turn()

func player_turn():
	print("Player Turn")
	# TODO: TELEPORT
	# TODO: VISIBLE UI
	emit_signal("hide_hud", false)

func enemy_turn():
	emit_signal("hide_hud", true)
	
	print("Enemy Turn")
	
	get_tree().change_scene_to_file("res://levels/map_shooter_test.tscn")
	
	next_turn()

func _on_endturn_pressed(): next_turn()
