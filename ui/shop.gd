extends Control

var troop_type_price : Array = [315, 500, 675, 888, 475]

func _ready():
	print("$", GameEvents.current_money)

func buy(id : int):
	if GameEvents.current_money >= troop_type_price[id]:
		GameEvents.types_troop[id] += 1
		GameEvents.current_money -= troop_type_price[id]
		print("$", GameEvents.current_money)
		print("troops: ", GameEvents.types_troop)
		GameEvents.emit_update_general_data()
	else:
		print("You need more money.")
		print("$", GameEvents.current_money)
		print("troops: ", GameEvents.types_troop)

func _on_done_button_pressed():
	self.visible = false

func _on_buy_button_1_pressed():
	buy(0)

func _on_buy_button_2_pressed():
	buy(1)

func _on_buy_button_3_pressed():
	buy(2)

func _on_buy_button_4_pressed():
	buy(3)

func _on_buy_button_5_pressed():
	buy(4)
