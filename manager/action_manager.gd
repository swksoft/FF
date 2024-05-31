class_name ActionManager extends Node

signal change_hud_turns
signal fight_selected

var available : bool

func recover_actions():
	GameEvents.actions = GameEvents.max_actions

func is_available():
	return available

func _ready():
	GameEvents.action_taken.connect(_on_action_taken)
	recover_actions()  # FIXME: SEÑAL PARA SEÑALIZAR QUE INICIO TURNO DEL JUGADOR Y NO OTRO
	
func _on_action_taken():
	if GameEvents.actions <= 0:
		print_debug("NO MORE TURNS")
		available = false
		return
		
	GameEvents.actions -= 1
	
	available = true
	
	emit_signal("change_hud_turns")

func _on_endturn_pressed():
	recover_actions()
	GameEvents.emit_update_general_data()
