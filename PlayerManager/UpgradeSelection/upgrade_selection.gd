extends Control

var options: Array[Upgrade] = []
@onready var container = $VBoxContainer/BoxContainer
@export var option_class: PackedScene

func show_upgrades():
	visible = true
	options = UpgradeDB.get_three_random_upgrades()
	get_tree().paused = true
	update()
	
func _on_upgrade_selected(_upgrade: Upgrade):
	get_tree().paused = false
	hide()
	
func update():
	if not is_node_ready(): return
	for child in container.get_children():
		container.remove_child(child)
	var first = true
	for i in range(options.size()):
		var child = option_class.instantiate()
		child.upgrade = options[i]
		container.add_child(child)
		if first:
			first = false
			child.grab_focus.call_deferred()
	
func _ready():
	UpgradeDB.show_upgrade_selection.connect(show_upgrades)
	UpgradeDB.upgrade_selected.connect(_on_upgrade_selected)
	update()
