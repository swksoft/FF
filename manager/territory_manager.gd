class_name TerritoryManager extends Node


	
	#if territory["lives"] > 0:
		#territory["lives"] -= 1
		#if territory["lives"] == 0:
			#territory["is_conquered"] = true
			#print(territory_name + " has been conquered!")
		#else:
			#print(territory_name + " has " + str(territory["lives"]) + " lives left.")
	#else:
		#print(territory_name + " is already conquered.")

func counterattack() -> Array: # (反撃)
	for territory in GameEvents.territories:
		print_debug(GameEvents.territories[territory]["confronted"])
	
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var counterattacking_territories = []
	
	for territory_name in GameEvents.territories.keys():
		var territory = GameEvents.territories[territory_name]
		if territory["confronted"]:
			#var chance = random.randf_range(0, 1)
			#if chance > 0.25:
			counterattacking_territories.push_back(territory_name)
				
	return counterattacking_territories

