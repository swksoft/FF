extends BaseComponent
class_name StatsComponent

signal effect(stat: String, value: float, time: float)
signal bonus_start(stat: String, value: float)
signal level_up(stat: String, value: float)

@export var attribute : CharacterStats

func _setup() -> void:
	await get_tree().process_frame
	
	if attribute == null:
		printerr("ERROR: StatsComponent sin attribute asignado en: ", self.get_path())
		get_tree().quit()
	
	is_ready = true

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
