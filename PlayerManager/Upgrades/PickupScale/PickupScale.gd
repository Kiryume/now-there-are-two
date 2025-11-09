extends Upgrade

@onready
var pickup_area: Area2D = (
	get_parent().get_parent().get_parent()
	.get_node("PickupArea")
)

func upgrade():
	pickup_area.scale += Vector2(0.1, 0.1)
	
func can_be_chosen() -> bool:
	return pickup_area.scale.x < 3
