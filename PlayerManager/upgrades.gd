extends Node2D

func _ready() -> void:
	UpgradeDB.upgrade_selected.connect(_on_upgrade_selected)
	var upgrades: Array[Upgrade] = []
	for child in get_children():
		if child is Upgrade:
			upgrades.append(child)
	UpgradeDB.all_upgrades = upgrades

func _on_upgrade_selected(upgrade: Upgrade):
	for child in get_children():
		if child.name == upgrade.name:
			if child is Upgrade:
				child.show()
				child.enable()
