extends Node

@export var all_upgrades: Array[Upgrade]

# This function will be called by your UI
func get_three_random_upgrades() -> Array[Upgrade]:
	var choices: Array[Upgrade] = []
	var shuffled_upgrades = all_upgrades.duplicate()
	shuffled_upgrades.shuffle()
	
	# Get 3 unique upgrades
	for i in range(min(3, shuffled_upgrades.size())):
		choices.append(shuffled_upgrades[i])
		
	return choices
