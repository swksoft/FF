extends Node2D

var shoot_type_scene : PackedScene = load("res://entities/troops/troop.tscn")
var escape_amount : int

signal escape_signal

func _ready():
	escape_amount = 0
	GameEvents.update_troop.connect(on_update_troop)
	print("Fleet: ", get_children())
	
	for shoot in GameEvents.shoot_troops:
		var shoot_type = shoot_type_scene.instantiate()
		add_child(shoot_type)

func _process(delta):
	if Input.is_action_pressed("esc"):
		escape_amount += 75 * delta
		print(escape_amount)
	else:
		escape_amount -= 75 * delta
		print(escape_amount)
	
	if escape_amount >= 100:
		escape_amount = 100
		emit_signal("escape_signal")
	elif escape_amount <= 0:
		escape_amount = 0
	
	if get_children().size() <= 0:
		print("game_over")
		# TODO: RETURN TO MAP AND ENEMY TURN MOMENT
		
func check_fleet():
	if get_children().size() <= 0:
		print("game_over")

func on_update_troop():
	check_fleet()
