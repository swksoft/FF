extends Node
class_name BaseComponent

var is_ready := false

func _setup() -> void:
	await get_tree().process_frame
		
	is_ready = true
