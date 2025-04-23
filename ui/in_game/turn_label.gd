extends Label

func set_target(target: int) -> void:
	text = ("PLAYER TURN" if (target == 0) else "ENEMY TURN")
