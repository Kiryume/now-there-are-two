extends Upgrade
class_name DirectDeposit

@export var chance := 0.05;
@export var increase_by := 0.05;
@export var maximum := 0.8;

var active: bool:
	get:
		return visible
	set(val):
		visible = val
		
func get_effective_chance() -> float:
	if not visible: return 0.
	return chance
	
func rand_chance() -> bool:
	var eff_chance := get_effective_chance()
	return randf() < eff_chance

func enable():
	pass

func upgrade():
	chance += increase_by
	
func can_be_chosen() -> bool:
	return chance < maximum

static func get_instance() -> DirectDeposit:
	for upg in UpgradeDB.all_upgrades:
		if upg is DirectDeposit:
			return upg
	return null
