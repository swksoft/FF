extends Node
class_name StaminaComponent

signal stamina_change(value: float)
signal stamina_drop(rate)
signal stamina_recharge(rate)
signal stamina_out

@export var stats: StatsComponent

var max_stamina
var current_stamina : float:
	get:
		return current_stamina
	set(value):
		current_stamina = clamp(value, 0, max_stamina)
var recharge_rate : float 
var recharge_penalty = 1

func _process(_delta: float) -> void:
	if current_stamina != null:
		get_parent().can_move = current_stamina > 0

func _enter_tree() -> void:
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo stamina")
		return
	max_stamina = stats.attribute.stamina
	current_stamina = max_stamina
	recharge_rate = stats.stamina_charge

func _on_stats_loaded():
	if stats.attribute.stamina == null:
		push_error("StatsComponent.attribute.stamina es null")
		return
	max_stamina = stats.attribute.stamina
	current_stamina = max_stamina
	print("Stamina inicializada: ", current_stamina)

func _on_stamina_recharge(rate) -> void:
	if current_stamina != null:
		if current_stamina <= max_stamina:
			current_stamina += rate * recharge_penalty
			current_stamina = clamp(current_stamina, 0, max_stamina) 
			if current_stamina == max_stamina:
				recharge_penalty = 1
				#get_parent().get_node("Sprite").modulate = Color(1, 1, 1)

func _on_stamina_drop(rate) -> void:
	if current_stamina != null:
		if current_stamina >= 0:
			current_stamina -= rate
			current_stamina = clamp(current_stamina, 0, max_stamina)
			if current_stamina == 0:
				emit_signal("stamina_out")

func _on_stamina_out() -> void:
	print_debug("SIN STAMINA")

func _on_stamina_change(value: float) -> void:
	if current_stamina != null:
		current_stamina += value

func charge(): return current_stamina + recharge_rate
