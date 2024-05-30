extends Node

var message_turn : String = "Turn " + str(GameEvents.current_turn + 1)
var message_territory_conquisted : String = "You've conquisted a territory!"
var message_escape : String = "Escape Succesful!"
var message_lose : String = "Space Megasex is death!"
var message_fail_conquest : String = "Conquest failed!"
var message_fail_defend : String = "Territory lost!"
var message_win_game : String = "You've conquered all!"
var message_cutsom : String

func next_turn():
	if GameEvents.whos_turn == 0:
		GameEvents.whos_turn = 1
	elif GameEvents.whos_turn == 1:
		GameEvents.whos_turn = 0

func enemy_turn():
	pass

func check_turn():
	GameEvents.emit_player_turn_start()

func _ready():
	check_turn()
	
	
	GameEvents.terrain_conquested.connect(_on_terrain_conquisted)
	
	ScreenMessage.emit_display_message_signal(message_turn)

func _on_endturn_pressed():
	GameEvents.current_turn += 1
	GameEvents.current_money += 100 + (100 * GameEvents.conquisted_territories)
	
	GameEvents.emit_player_turn_end()
	
	# TODO: TURN MANAGER NO PAUSA LA ESCENA
	# FIXME: BOTONES SIGUEN INACTIVOS
	#await get_tree().create_timer(1.0).timeout
	#GameEvents.emit_update_general_data()
	
	# TODO: CUANDO PASE EL TURNO DEL ENEMIGO
	message_turn = "Turn " + str(GameEvents.current_turn + 1)
	
	if all_territories_conquered():
		ScreenMessage.emit_display_message_signal(message_territory_conquisted)
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://ui/win_screen.tscn")
	else:
		GameEvents.emit_player_turn_start()
		ScreenMessage.emit_display_message_signal(message_turn)

func _on_terrain_conquisted(name_territory):
	conquer_territory(name_territory)
	
func conquer_territory(name_territory: String):
	print_debug(name_territory)
	if GameEvents.territories.has(name_territory):
		var territory = GameEvents.territories[name_territory]
		territory["is_conquered"] = true
		print(name_territory + " has been conquered!")
	else:
		print("Territory " + name_territory + " does not exist.")
	
	print_debug(GameEvents.territories)

func all_territories_conquered() -> bool:
	for territory in GameEvents.territories.values():
		if not territory["is_conquered"]:
			return false
	return true
