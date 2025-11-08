# Upgrade.gd
extends Node2D
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

func enable():
	pass

func upgrade():
	pass
	
func can_be_chosen() -> bool:
	return true
