extends Upgrade

@onready
var parent : WeaponController = get_parent().get_parent()

var nozzle : PackedScene = preload("res://PlayerManager/Player/Nozzle.tscn")

func enable() -> void:
	# Nozzle 1
	var nozzle1 = nozzle.instantiate()
	nozzle1.position = Vector2(0, 42)
	nozzle1.rotation_degrees = 90
	parent.add_child.call_deferred(nozzle1)
	
	# Nozzle 2
	var nozzle2 = nozzle.instantiate()
	nozzle2.position = Vector2(-42, 0)
	nozzle2.rotation_degrees = 180
	parent.add_child.call_deferred(nozzle2)
	
	# Nozzle 3
	var nozzle3 = nozzle.instantiate()
	nozzle3.position = Vector2(0, -42)
	nozzle3.rotation_degrees = 270
	parent.add_child.call_deferred(nozzle3)
