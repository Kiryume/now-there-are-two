extends Control

var options: Array[Upgrade] = []
@onready var container = $BoxContainer
@export var option_class: PackedScene

func show_upgrades():
	visible = true
	options = UpgradeDB.get_three_random_upgrades()
	get_tree().paused = true
	update()
	
func _on_upgrade_selected(_upgrade: Upgrade):
	print("upgrade selected")
	get_tree().paused = false
	hide()
	
func update():
	if not is_node_ready(): return
	var children := container.get_children()
	if children.size() > options.size():
		var to_leave = children.slice(0, 3)
		var to_remove = children.slice(3)
		for child in to_remove:
			container.remove_child(child)
		children = to_leave
	if options.size() > children.size():
		var missing = options.size() - children.size()
		for i in range(missing):
			var child = option_class.instantiate()
			children.append(child)
			container.add_child(child)
	for i in range(options.size()):
		children[i].upgrade = options[i]
	
func _ready():
	UpgradeDB.show_upgrade_selection.connect(show_upgrades)
	UpgradeDB.upgrade_selected.connect(_on_upgrade_selected)
	update()
