extends Node

var all_upgrades: Array[Upgrade]

var total_enemies = 0
var total_xp := 0.
var last_level := 0

func reset():
	total_enemies = 0
	total_xp = 0
	last_level = 0

func get_level():
	return (total_xp / 5) as int
	
func gain_xp(xp: float):
	total_xp += xp
	if get_level() > last_level:
		last_level = get_level()
		emit_signal("show_upgrade_selection")

# This function will be called by your UI
func get_three_random_upgrades() -> Array[Upgrade]:
	# debug only
	return all_upgrades.duplicate()
	var shuffled_upgrades = all_upgrades.filter(func (upgrade): return upgrade.can_be_chosen())
	shuffled_upgrades.shuffle()
	return shuffled_upgrades.slice(0, min(3, all_upgrades.size()))

signal show_upgrade_selection
signal upgrade_selected(upgrade: Upgrade)
