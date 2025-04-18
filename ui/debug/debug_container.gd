extends PanelContainer

@export var target : CharacterBody2D

@onready var char_name: Label = $V/Name
@onready var health: Label = $V/Health
@onready var stamina: Label = $V/Stamina
@onready var speed: Label = $V/Speed

func _ready() -> void:
	if target == null:
		return
	
func _process(_delta: float) -> void:
	if target == null:
		set_process(false)
		health.text = "health: FUCKING DEATH"
		return
	
	char_name.text = "name: " + target.stats.attribute.name_character
	health.text = "health: %.0f" % target.health.current_health
	speed.text = "speed: %.0f" % target.stats.attribute.speed_max
	stamina.text = "stamina: %.0f" % target.stamina.current_stamina
