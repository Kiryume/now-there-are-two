extends Node2D
class_name WeaponController

signal on_shoot
signal on_stats_changed

var stats = {
	"fire_rate": 1.0,
	"damage": 10,
	"move_speed": 300.0
}

@onready
var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	update_stats()
	on_stats_changed.connect(update_stats) # Re-connect for future upgrades
	apply_upgrade(UpgradeDB.all_upgrades[0])

func apply_upgrade(upgrade: Upgrade):
	# Step 1: Apply all stat modifiers
	for stat_name in upgrade.stat_modifiers:
		if stats.has(stat_name):
			var modifier = upgrade.stat_modifiers[stat_name]
			# You can decide to add, multiply, etc.
			stats[stat_name] = stats[stat_name] * modifier # Example: multiplier
	on_stats_changed.emit()

	if upgrade.behavior_scene:
		var new_behavior = upgrade.behavior_scene.instantiate()
		add_child(new_behavior)

func update_stats():
	shoot_timer.wait_time = 1.0 / stats["fire_rate"]

func _on_shoot_timer_timeout() -> void:
	on_shoot.emit()
