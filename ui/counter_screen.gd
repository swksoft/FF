extends CanvasLayer

# FIXME: DINERO NO SUBE AL PARECER 
# FIXME: HAY COLISIONES/PROYECTILES ROTOS

var territory : String
var layer_num = 5

@onready var message = $PanelContainer/V/Message
@onready var desist_button = $PanelContainer/V/H/DesistButton

func _ready():
	layer = layer_num
	
	#get_tree().paused = true
	
	if GameEvents.player_lives <= 0:
		desist_button.visible = false
	message.text = territory.to_upper() + " IS COUNTERATTACKING"

func _on_fight_button_pressed():
	GameEvents.emit_defend(territory)

func _on_desist_button_pressed():
	#get_tree().paused = false
	GameEvents.emit_life_down()
	queue_free()
