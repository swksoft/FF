extends Panel

@onready var total = $V/Total
@onready var shoot = $V/Shoot
@onready var laser = $V/Laser
@onready var homing = $V/Homing
@onready var shield = $V/Shield
@onready var bomb = $V/Bomb

func _ready():
	GameEvents.data_troup.connect(_on_data_troup_signal)

func update():
	total.text = "Total Troops: " + str(GameEvents.get_total_troops())
	shoot.text = "Shoot Type: " + str(GameEvents.types_troop[0])
	laser.text = "Laser Type: " + str(GameEvents.types_troop[1])
	homing.text = "Homing Type: " + str(GameEvents.types_troop[2])
	shield.text = "Shield Type: " + str(GameEvents.types_troop[3])
	bomb.text = "Bomb Troops: " + str(GameEvents.types_troop[4])

func _on_data_troup_signal():
	update()
