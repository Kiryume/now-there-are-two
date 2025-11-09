extends Upgrade

@onready
var timer : Timer = get_parent().get_parent().get_node("ShootTimer")

func upgrade():
	timer.wait_time *= .9
	
func can_be_chosen() -> bool:
	return timer.wait_time > .2
