extends Enemy

func _physics_process(delta: float) -> void:
	move_to_nearest_player(delta)
