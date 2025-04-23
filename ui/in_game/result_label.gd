extends Label

func set_target(target: String) -> void:
	text = "HOLY SHIT IT'S A DRAW!" if target == "DRAW" else (target + " OBLITERATED THE OPONENT!")
