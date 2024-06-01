extends VBoxContainer

#FIXME: EXPLOSIONS WORKS AT RANDOM

@export var territory_name : String = "None"
@export var conquered_image : CompressedTexture2D

var heart_scene : PackedScene = load("res://ui/heart.tscn")
var hollow_heart_scene : PackedScene = load("res://ui/hollow_heart.tscn")
var heart_good : PackedScene = load("res://ui/heart_good.tscn")
var icons : Array = [preload("res://assets/sprites/iconsga3.png"), preload("res://assets/sprites/iconsga1.png"), preload("res://assets/sprites/iconsga4.png"), preload("res://assets/sprites/iconsga2.png"), preload("res://assets/sprites/iconsga5.png"), preload("res://assets/sprites/iconsga6.png")]

@onready var label = $Label
@onready var texture_button = $TextureButton
@onready var lives_label = $LivesLabel

func update_lives():
	var total_lives = GameEvents.territories[territory_name.to_lower()]["lives"]
	
	lives_label.text = str(total_lives)
	
	if total_lives <= 0:
		texture_button.texture_normal = conquered_image
		lives_label.text = "Mine"
		texture_button.disabled = true

func _ready():
	GameEvents.terrain_lives_hud.connect(_on_terrain_lives_hud)
	
	update_lives()
	
	# NAME 
	if GameEvents.territories.has(territory_name.to_lower()):
		label.text = territory_name
	# LIVES
	
	
func _on_texture_button_pressed():
	if GameEvents.actions <= 0:
		return
	await GameEvents.emit_action_taken()
	await GameEvents.emit_fight(territory_name.to_lower())

func _on_terrain_lives_hud():
	update_lives()
