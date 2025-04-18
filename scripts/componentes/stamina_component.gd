extends Node
class_name StaminaComponent

signal stamina_change(value: float)
signal stamina_drop(rate)
signal stamina_out

@export var stats: StatsComponent

var max_stamina : float:
	get:
		return max_stamina
	set(value):
		max_stamina = clamp(value, 0, 9999)
var current_stamina : float:
	get:
		return current_stamina
	set(value):
		current_stamina = clamp(value, -9999, max_stamina)
		if current_stamina <= 0:
			stamina_out.emit()
var recharge_rate : float
var recharge_penalty = 1

func _enter_tree() -> void:
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo stamina")
		return
	max_stamina = stats.attribute.stamina_max
	current_stamina = max_stamina
	recharge_rate = stats.attribute.stamina_charge
	GameEvents.stamina_update.emit(current_stamina)

func _ready() -> void:
	GameEvents.stamina_update.emit(current_stamina)

func _on_stamina_drop(rate) -> void:
	current_stamina -= rate
	GameEvents.stamina_update.emit(current_stamina)

func _on_stamina_out() -> void:
	get_parent().can_move = false

func _on_stamina_change(value: float) -> void:
	current_stamina += value

func charge(): return current_stamina + recharge_rate
