extends HBoxContainer

@onready var turn_label = $TurnLabel
@onready var money_label = $MoneyLabel
@onready var actions_label = $ActionsLabel

func _ready():
	GameEvents.characters_ready.update_general_data.connect(on_general_data_update)

func update_hud():
	turn_label.text = "TURN: " + str(GameEvents.current_turn)
	money_label.text = "MONEY: $" + str(GameEvents.current_money)
	if GameEvents.actions <= 0:
		actions_label.add_theme_color_override("font_color", Color.RED)
	else:
		actions_label.add_theme_color_override("font_color", Color.WHITE)
	actions_label.text = "ACTIONS: " + str(GameEvents.actions)

func on_general_data_update():
	update_hud()

func _on_action_manager_change_hud_turns():
	update_hud()
