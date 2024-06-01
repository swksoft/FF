extends Control

@export var counter_attack_scene : PackedScene
var counter_count = 0
var layer_num = 5

func spawn_counter_message():
	var counter_attack = counter_attack_scene.instantiate()
	for i in counter_count:
		counter_attack.layer_num += layer_num
		layer_num += 1
		add_child(counter_attack)
	
