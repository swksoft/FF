extends Node
class_name StateManager

signal transitioned

func _on_change_state_timeout():
	emit_signal("transitioned")
