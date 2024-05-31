extends Node2D

var shoot_type_scene : PackedScene = load("res://entities/troops/troop.tscn")
var shield_type_scene : PackedScene = load("res://entities/troops/troop_shield.tscn")
var laser_type_scene : PackedScene = load("res://entities/troops/troop_laser.tscn")
var bomb_type_scene : PackedScene = load("res://entities/troops/troop_bomb.tscn")
var escape_amount : int

signal escape_signal
signal change_escape_hud(escape_amount)
signal change_troop_hud()

func _ready():
	GameEvents.troop_down.connect(_on_troop_down)
	
	escape_amount = 0
	GameEvents.update_troop.connect(on_update_troop)
	print("Fleet: ", get_children())
	
	for shoot in GameEvents.types_troop[0]:
		var shoot_type = shoot_type_scene.instantiate()
		add_child(shoot_type)
	for shield in GameEvents.types_troop[-1]:
		var shield_type = shield_type_scene.instantiate()
		add_child(shield_type)
	for laser in GameEvents.types_troop[1]:
		var laser_type = laser_type_scene.instantiate()
		add_child(laser_type)
	for bomb in GameEvents.types_troop[3]:
		var bomb_type = bomb_type_scene.instantiate()
		add_child(bomb_type)

func _on_troop_down(type):
	GameEvents.types_troop[type] -= 1
	emit_signal("change_troop_hud")

func _process(delta):
	if Input.is_action_pressed("esc"):
		escape_amount += 75 * delta
	else:
		escape_amount -= 75 * delta
	
	if escape_amount >= 100:
		escape_amount = 100
		emit_signal("escape_signal")
	elif escape_amount <= 0:
		escape_amount = 0
	
	emit_signal("change_escape_hud", escape_amount)
	
	#if get_children().size() <= 0:
		#print("game_over")
		# TODO: RETURN TO MAP AND ENEMY TURN MOMENT
		
func check_fleet():
	if get_children().size() <= 0:
		print("game_over")

func on_update_troop():
	check_fleet()
