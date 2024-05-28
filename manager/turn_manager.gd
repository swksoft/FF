extends Node

var message_turn : String = "Turn " + str(GameEvents.current_turn + 1)

func _ready():
	GameEvents.current_turn = 0
	GameEvents.emit_player_turn_start()
	ScreenMessage.emit_display_message_signal(message_turn)

func new_round():
	GameEvents.emit_player_turn_start()
	ScreenMessage.emit_display_message_signal(message_turn)

func _on_endturn_pressed():
	
	
	GameEvents.current_turn += 1
	GameEvents.current_money += 100 + (100 * GameEvents.conquisted_territories)
	GameEvents.emit_player_turn_end()
	GameEvents.emit_update_general_data()
	await get_tree().create_timer(2).timeout
	# TODO: CUANDO PASE EL TURNO DEL ENEMIGO
	message_turn = "Turn " + str(GameEvents.current_turn + 1)
	new_round()
