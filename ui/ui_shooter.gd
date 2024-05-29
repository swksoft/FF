extends CanvasLayer

@onready var total_troops = $Control/PlayerTroopsContainer/V/TotalTroops
@onready var total_money = $Control/TotalMoneyContainer/V/TotalMoney
@onready var total_earnings = $Control/EarningsContainer2/V/TotalEarnings
@onready var total_enemy_troops = $Control/EnemyTroopsContainer/V/TotalEnemyTroops
@onready var progress_bar = $Control/VBoxContainer/ProgressBar

func _ready():
	GameEvents.update_data_shooter.connect(_on_update_data_shooter)

func update():
	total_troops.text = GameEvents.total_troops
	total_money.text = GameEvents.current_money
	total_earnings.text = "XD"
	total_enemy_troops.text = "XD"
	#progress_bar.

func _on_update_data_shooter():
	print("a")
	update()
	
	
