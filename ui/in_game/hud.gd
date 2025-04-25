extends CanvasLayer

@export var entities: Array[Node]

@onready var loading_screen: ColorRect = $Hud/LoadingScreen
@onready var turn_label: Label = $Hud/TurnLabel
@onready var result_label: Label = $Hud/ResultLabel
@onready var turn_number_label: Label = $Hud/TurnNumberLabel
@onready var timer_label: Label = $Hud/TimerLabel

var nodes_loading := 0

func _ready() -> void:
	layer = 999
	GameEvents.loading_started.connect(_on_node_loading_started)
	GameEvents.loading_finished.connect(_on_node_loading_finished)

func _on_node_loading_started() -> void:
	nodes_loading += 1

	loading_screen.visible = true
	
	print_debug("Nodos cargando: ", nodes_loading)

func _on_node_loading_finished() -> void:
	nodes_loading -= 1
	
	if nodes_loading <= 0:
		loading_screen.visible = false
	layer = 1
	
	turn_label.visible = true
	result_label.visible = true
	turn_number_label.visible = true

func _on_turn_manager_battle_turn_changed(turn_who: Variant, number) -> void:
	turn_label.set_target(turn_who)
	turn_number_label.set_number(number)

func _on_turn_manager_battle_battle_ended(winner: String) -> void:
	result_label.set_target(str(winner))

func _on_turn_manager_battle_turn_time_send(amount: float) -> void:
	timer_label.visible = true
	timer_label.set_time(amount)
