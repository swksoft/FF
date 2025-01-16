extends Node
class_name HealthComponent

signal health_change(value)
signal dead
signal invulneravility

var max_health : float
var current_health : float:
	get:
		return current_health
	set(value):
		current_health = clamp(value, 0, max_health)

@export var stats: StatsComponent

func _enter_tree() -> void:
	if stats == null:
		push_error("StatsComponent no encontrado en el nodo health")
		return
	max_health = stats.attribute.health + stats.attribute.bonus.bonus_stat["health"]
	current_health = max_health
	
func _on_health_change(amount: int):
	current_health = max(0, current_health - amount)
	#current_health -= amount
	invulneravility.emit()
	if current_health == 0:
		emit_signal("dead")
	print(current_health)

func _on_dead() -> void:
	get_parent().die()

func _on_invulneravility() -> void:
	$TimerInvulnerability.start()
	get_parent().invulnerabilty = true
	
func _on_timer_invulnerability_timeout() -> void:
	get_parent().invulnerabilty = false

func _on_hurtbox_component_hit_detected(damage: int) -> void:
	health_change.emit(damage)
