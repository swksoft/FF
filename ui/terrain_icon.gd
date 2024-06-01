extends VBoxContainer

#FIXME: EXPLOSIONS DOESNT WORK

@export var territory_name : String = "None"

var heart_scene : PackedScene = load("res://ui/heart.tscn")
var hollow_heart_scene : PackedScene = load("res://ui/hollow_heart.tscn")
var heart_good : PackedScene = load("res://ui/heart_good.tscn")
var icons : Array = [preload("res://assets/sprites/iconsga3.png"), preload("res://assets/sprites/iconsga1.png"), preload("res://assets/sprites/iconsga4.png"), preload("res://assets/sprites/iconsga2.png"), preload("res://assets/sprites/iconsga5.png"), preload("res://assets/sprites/iconsga6.png")]

@onready var label = $Label
@onready var texture_button = $TextureButton

func _ready():
	# NAME 
	if GameEvents.territories.has(territory_name.to_lower()):
		label.text = territory_name
	# ICON
	
	# LIVES

func _on_texture_button_pressed():
	if GameEvents.actions <= 0:
		return
	await GameEvents.emit_action_taken()
	await GameEvents.emit_fight(territory_name.to_lower())
	
	
	#damage_terrain() # DEBUG
	
	#get_tree().change_scene_to_file("res://levels/map_shooter_test.tscn")
