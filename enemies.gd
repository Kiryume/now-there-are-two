extends Node2D

@export
var spawn_offset = 1000.;

@export
var enemyscenes: Array[PackedScene]

func get_max_enemies():
	return 30 + UpgradeDB.level * 5

func pick_random_weighted():
	var level = UpgradeDB.level - 1
	var weights = [min(10-level, 5), min(level, 5)]
	var sum = 0
	for weight in weights:
		sum += weight
	var rnd = randf()
	var counter = 0
	var i = 0
	for weight in weights:
		counter += weight
		if counter / sum > rnd:
			return enemyscenes[i]
		i += 1

func _on_enemy_spawn_timer_timeout() -> void:
	var childamount = get_children().size()
	var max_enemies = get_max_enemies()
	if childamount > max_enemies:
		return
	var loc = get_random_location()
	var enemyscene = pick_random_weighted()
	var child: Node2D = enemyscene.instantiate()
	child.position = loc
	child.level = get_random_level()
	add_child(child)

func get_random_level():
	return clampf(randfn(UpgradeDB.level, .75), 1, 5)

func get_random_location() -> Vector2:
	var random = randf() * PI * 2
	var center = PlayerList.get_center()
	return Vector2(center.x + sin(random) * spawn_offset, center.y + cos(random) * spawn_offset)
