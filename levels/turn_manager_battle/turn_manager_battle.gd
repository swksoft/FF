class_name TurnManagerBattle
extends Node

signal turn_changed(turn_who, number)
signal battle_ended(winner: String)
signal turn_time_send(amount : float)

@export var max_turns: int = 5
@export var turn_who: turn_target
@export var randomized_turn : bool
@export var time_round : float

enum turn_target { PLAYER_TURN, ENEMY_TURN }

var current_turn: int = 0
var relevant_players : int
var relevant_enemies : int

@onready var change_turn_timer: Timer = $ChangeTurnTimer
@onready var tick_timer: Timer = $TickTimer

func update_entity_count(type: String, amount : int) -> void:
	match type:
		"player":
			relevant_players += amount
			if relevant_players <= 0:
				relevant_players = 0
				battle_ended.emit("ENEMY")
		"enemy":
			relevant_enemies += amount
			if relevant_enemies <= 0:
				relevant_enemies = 0
				battle_ended.emit("PLAYER")

func count_entities() -> void:
	relevant_players = 0
	relevant_enemies = 0
	
	relevant_players = get_tree().get_nodes_in_group("Player").size()
	relevant_enemies = get_tree().get_nodes_in_group("Enemy").size()

func _ready() -> void:
	
	
	await get_tree().process_frame  # Espera a que todo en la escena se cargue.
	start_battle()

func start_battle():
	count_entities()
	
	if randomized_turn:
		turn_who = randi() % 2 # 0 = PLAYER_TURN, 1 = ENEMY_TURN
		
	turn_changed.emit(turn_who, current_turn)
	current_turn = 0
	
	change_turn_timer.wait_time = time_round
	change_turn_timer.start()
	
func end_turn():
	change_turn_timer.paused = true
	
	if turn_who == turn_target.PLAYER_TURN:
		turn_who = turn_target.ENEMY_TURN
	else:
		turn_who = turn_target.PLAYER_TURN
		current_turn += 1

	if current_turn > max_turns:
		battle_ended.emit("DRAW")
	else:
		turn_changed.emit(turn_who, current_turn)
	
	change_turn_timer.wait_time = time_round
	change_turn_timer.start()
	change_turn_timer.paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and OS.is_debug_build():
		get_tree().reload_current_scene()
	elif event.is_action_pressed("right_click"):
		end_turn()

func _on_change_turn_timer_timeout() -> void:
	end_turn()

func _on_tick_timer_timeout() -> void:
	turn_time_send.emit(change_turn_timer.time_left)
