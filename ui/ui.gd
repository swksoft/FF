extends Control

@onready var stats_panel = $CanvasLayer/StatsPanel
@onready var shop = $CanvasLayer/Shop
@onready var tutorial_screen = $CanvasLayer/TutorialScreen
var canvas_layer 

@onready var player_lives_label = $CanvasLayer/PlayerInfoV/PlayerLivesLabel

func _ready():
	check_life()
	GameEvents.emit_update_general_data()
	GameEvents.emit_terrain_lives_hud()
	
	GameEvents.life_up.connect(_on_life_up)
	GameEvents.life_down.connect(_on_life_down)

func _on_button_mouse_entered():
	GameEvents.emit_data_troup()
	stats_panel.visible = true

func _on_button_mouse_exited():
	stats_panel.visible = false

func _on_add_button_pressed():
	shop.visible = true

func _on_button_pressed():
	tutorial_screen.visible = true

func _on_turn_manager_hide_hud(activate):
	canvas_layer = $CanvasLayer
	
	if activate == true:
		canvas_layer.visible = false
	else:
		canvas_layer.visible = true

func check_life():
	player_lives_label.text = str(GameEvents.player_lives)

func _on_life_up():
	GameEvents.player_lives += 1
	check_life()

func _on_life_down():
	GameEvents.player_lives -= 1
	check_life()
