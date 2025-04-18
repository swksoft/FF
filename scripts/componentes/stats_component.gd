extends Node
class_name StatsComponent

signal effect(stat: String, value: float, time: float)
signal bonus_start(stat: String, value: float)
signal level_up(stat: String, value: float)

@export var attribute : CharacterStats

func _ready() -> void:
	if attribute == null:
		push_error("StatsComponent no encontrado en el nodo stats")
		return

func emit_stats_loaded():
	GameEvents.emit_stats_loaded()

func _on_bonus_start(stat: String, value: float) -> void:
	attribute.stat *= value

func _on_effect(stat: String, value: float, time: float) -> void:
	$Cooldown.wait_time = time
	$Cooldown.start()
	attribute.stat *= value

func _on_level_up(stat: String, value: float) -> void:
	attribute.stat += value

func _on_cooldown_timeout() -> void:
	# TODO: one shot TRUE?
	attribute.stat *= 1
