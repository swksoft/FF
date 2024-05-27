extends Control

@onready var stats_panel = $CanvasLayer/StatsPanel
@onready var shop = $CanvasLayer/Shop
@onready var tutorial_screen = $CanvasLayer/TutorialScreen
@onready var turn_label = $CanvasLayer/HBoxContainer2/TurnLabel
@onready var money_label = $CanvasLayer/HBoxContainer2/MoneyLabel

func _ready():
	pass #

func _on_button_mouse_entered():
	# TODO: SHOW DATA
	stats_panel.visible = true
	print("Info opened")

func _on_button_mouse_exited():
	# TODO: HIDE DATA
	stats_panel.visible = false
	print("Info closed")


func _on_add_button_pressed():
	shop.visible = true


func _on_button_pressed():
	tutorial_screen.visible = true
