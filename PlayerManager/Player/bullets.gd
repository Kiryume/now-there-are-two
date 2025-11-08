extends Marker2D

@export
var bullet_scene: PackedScene

func _on_shoot_timer_timeout() -> void:
	var child: BaseProjectile = bullet_scene.instantiate() as BaseProjectile
	child.shooter = owner
	var root = get_tree().root.get_child(0)
	root.add_child(child)
	child.transform = global_transform
	child.text.color = (owner as Player).target_color * 2
