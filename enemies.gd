extends Node2D

@export
var spawn_offset = 1000.;

@export
var max_enemies = 20;

@export
var enemyscene: PackedScene

func _on_enemy_spawn_timer_timeout() -> void:
	var childamount = get_children().size()
	if childamount > max_enemies:
		return
	var loc = get_random_location()
	var child: Node2D = enemyscene.instantiate()
	child.position = loc
	child.level = get_random_level()
	add_child(child)

func get_random_level():
	return clampf(randfn(UpgradeDB.get_level(), .75), 1, 5)

func get_random_location() -> Vector2:
	var random = randf() * PI * 2
	var center = PlayerList.get_center()
	return Vector2(center.x + sin(random) * spawn_offset, center.y + cos(random) * spawn_offset)
