@tool
extends Control

@onready var Title = $MarginContainer/HBoxContainer/BoxContainer/Title
@onready var Description = $MarginContainer/HBoxContainer/BoxContainer/Description
@onready var Icon = $MarginContainer/HBoxContainer/Icon

@export var upgrade: Upgrade:
	set(val):
		upgrade = val
		update()

func update():
	if not is_node_ready(): return
	if not upgrade: return
	Title.text = upgrade.upgrade_name
	Description.text = upgrade.description
	Icon.texture = upgrade.icon

func _ready():
	update()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			UpgradeDB.upgrade_selected.emit(upgrade)
