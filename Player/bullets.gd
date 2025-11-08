extends Marker2D

@export
var bullet_scene: PackedScene

func _on_shoot_timer_timeout() -> void:
	var child: BaseProjectile = bullet_scene.instantiate() as BaseProjectile
	owner.owner.add_child(child)
	child.transform = global_transform
