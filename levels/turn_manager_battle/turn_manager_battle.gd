class_name TurnManagerBattle
extends Node

signal turn_changed(turn_who)
signal battle_ended(winner: String)

@export var max_turns: int = 5
@export var turn_who: turn_target

enum turn_target {PLAYER_TURN, ENEMY_TURN}

var current_turn: int = 0

func _ready() -> void:
	await get_tree().process_frame  # Espera a que todo en la escena se cargue.
	start_battle()

func start_battle():
	turn_changed.emit(turn_who)
	current_turn = 0
	
func end_turn():
	if turn_who == turn_target.PLAYER_TURN:
		turn_who = turn_target.ENEMY_TURN
	else:
		turn_who = turn_target.PLAYER_TURN
		current_turn += 1

	if current_turn > max_turns:
		battle_ended.emit("DRAW")
	else:
		turn_changed.emit(turn_who)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right_click"):
		end_turn()
