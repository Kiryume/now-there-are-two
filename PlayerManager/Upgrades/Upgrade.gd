# Upgrade.gd
extends Resource
class_name Upgrade

# --- Basic Info ---
@export var upgrade_name: String = "Upgrade"
@export_multiline var description: String = "Does cool stuff."
@export var icon: Texture


@export var stat_modifiers: Dictionary = {
	"fire_rate": 1.0,
	"damage": 1.0,
	"move_speed": 1.0
}

# --- Part 2: Behavior "Plug-in" ---
# For "4 nozzles" or "laser on collide"
@export var behavior_scene: PackedScene
