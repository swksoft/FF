extends Node
class_name EventManager

@onready var ani: AnimationPlayer = $Ani
@onready var label: Label = $CanvasLayer/Control/Label

func _play_animation_with_delay(text: String, animation_name: String, pre_delay: float = 0.0, post_delay: float = 0.0):
	pause_game(true)
	label.text = text
	await get_tree().create_timer(pre_delay).timeout
	ani.play(animation_name)
	await ani.animation_finished
	await get_tree().create_timer(post_delay).timeout
	pause_game(false)

func pause_game(paused : bool):
	get_tree().paused = paused

func show_round(round_number: int) -> void:
	pause_game(true)
	
	ani.play("round")
	# Mostrar primero solo "ROUND"
	label.text = "ROUND"
	await get_tree().create_timer(0.5).timeout
	
	# Ahora agregar el número
	label.text = "ROUND %d" % (round_number + 1)
	
	await ani.animation_finished
	
	await get_tree().create_timer(0.5).timeout
	pause_game(false)

func show_round_delayed(round_number: int) -> void:
	await get_tree().create_timer(0.75).timeout
	pause_game(true)
	
	ani.play("round")
	# Mostrar primero solo "ROUND"
	label.text = "ROUND"
	await get_tree().create_timer(0.5).timeout
	
	# Ahora agregar el número
	label.text = "ROUND %d" % (round_number + 1)
	
	await ani.animation_finished
	
	await get_tree().create_timer(0.5).timeout
	pause_game(false)

func show_battle_start():
	await _play_animation_with_delay("START", "battle_start")

func show_draw_screen():
	await _play_animation_with_delay("DRAW", "draw_screen")

func show_enemy_turn():
	await _play_animation_with_delay("ENEMY TURN", "enemy_turn")

func show_enemy_delayed():
	await _play_animation_with_delay("ENEMY TURN", "enemy_turn", 1, 1)

func show_player_turn():
	await _play_animation_with_delay("PLAYER TURN", "player_turn")

func show_player_delayed():
	await _play_animation_with_delay("PLAYER TURN", "player_turn", 1, 1)

func show_win_screen():
	# TODO: CHANGE_SCENE A MAPA
	await _play_animation_with_delay("YOU WIN", "win_screen")

func show_lose_screen():
	await _play_animation_with_delay("YOU LOSE", "lose_screen")
