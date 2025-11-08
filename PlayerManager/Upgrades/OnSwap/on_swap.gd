extends Upgrade


# Called when the node enters the scene tree for the first time.
func enable() -> void:
	PlayerList.players_swapped.connect(laser_swap)

func laser_swap():
	pass
