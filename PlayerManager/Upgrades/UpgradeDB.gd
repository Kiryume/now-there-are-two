extends Node

var all_upgrades: Array[Upgrade]

var total_enemies = 0
var total_xp := 0.
var level := 1

func reset():
	total_enemies = 0
	total_xp = 0
	level = 1
	
func gain_xp(xp: float):
	total_xp += xp
	if calculate_xp_for_next_level() <= total_xp:
		level += 1
		emit_signal("show_upgrade_selection")
		
func calculate_xp_for_next_level() -> int:
	var base_xp: int = 5
	var growth_factor: float = 1.3
	var exponent: float = 1.25

	var xp: float = base_xp * pow(growth_factor, pow(level-1, exponent))
	return round(xp)
	
# This function will be called by your UI
func get_three_random_upgrades() -> Array[Upgrade]:
	# debug only
	# return all_upgrades.duplicate()
	var shuffled_upgrades = all_upgrades.filter(func (upgrade): return upgrade.can_be_chosen())
	shuffled_upgrades.shuffle()
	return shuffled_upgrades.slice(0, min(3, all_upgrades.size()))

signal show_upgrade_selection
signal upgrade_selected(upgrade: Upgrade)
