extends Control

@onready var stats_panel = $CanvasLayer/StatsPanel
@onready var shop = $CanvasLayer/Shop
@onready var tutorial_screen = $CanvasLayer/TutorialScreen
var canvas_layer 

func _ready():
	GameEvents.emit_update_general_data()

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
