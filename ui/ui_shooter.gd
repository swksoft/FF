extends CanvasLayer

@onready var total_troops = $Control/PlayerTroopsContainer/V/TotalTroops
@onready var total_earnings = $Control/EarningsContainer2/V/TotalEarnings
@onready var total_enemy_troops = $Control/EnemyTroopsContainer/V/TotalEnemyTroops
@onready var progress_bar = $Control/VBoxContainer/ProgressBar
@onready var time_label = $Control/TimerContainer/HBoxContainer/TimeLabel
@onready var timer_container = $Control/TimerContainer

func _on_level_manager_time_passed_hud(current_time):
	timer_container.visible = true
	time_label.text = str(current_time)

func _on_player_control_change_escape_hud(escape_amount):
	progress_bar.value = escape_amount

func _on_level_manager_update_hud(money_get, total_enemies):
	total_earnings.text = "$" + str(money_get)
	total_enemy_troops.text = str(total_enemies)
	total_troops.text = str(GameEvents.get_total_troops())

func _on_player_control_change_troop_hud():
	total_troops.text = str(GameEvents.get_total_troops())
