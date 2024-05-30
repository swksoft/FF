extends Node

signal take_action(who)

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
	elif GameEvents.whos_turn == 1:
		GameEvents.whos_turn = 0
	
	print(GameEvents.whos_turn)
	
	emit_signal("take_action", GameEvents.whos_turn)
	
	GameEvents.current_turn += 1
	#GameEvents.current_money += 100 + (100 * )

func _ready():
	next_turn()

func player_turn():
	pass

func enemy_turn():
	pass

func _on_take_action(who):
	if who == 0:
		player_turn()
	else:
		enemy_turn()

func _on_end_turn():
	next_turn()
