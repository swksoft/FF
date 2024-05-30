extends Node

func attack(territory_name: String):
	var territory = GameEvents.territories[territory_name]
	
	dispute_territory(territory_name)
	
	#if territory["lives"] > 0:
		#territory["lives"] -= 1
		#if territory["lives"] == 0:
			#territory["is_conquered"] = true
			#print(territory_name + " has been conquered!")
		#else:
			#print(territory_name + " has " + str(territory["lives"]) + " lives left.")
	#else:
		#print(territory_name + " is already conquered.")

func dispute_territory(territory_name: String):
	GameEvents.territories[territory_name]["confronted"] = true
	print(territory_name + " is now in dispute.")

func counterattack() -> Array:
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var counterattacking_territories = []
	
	for territory_name in GameEvents.territories.keys():
		var territory = GameEvents.territories[territory_name]
		if territory["confronted"]:
			var chance = random.randf_range(0, 1)
			if chance > 0.5:
				counterattacking_territories.append(territory_name)
				print(territory_name + " launches a counterattack!")
				
	return counterattacking_territories
