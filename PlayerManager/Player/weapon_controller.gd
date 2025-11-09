extends Node2D
class_name WeaponController

signal on_shoot

@onready
var shoot_timer: Timer = $ShootTimer

func _process(_delta: float) -> void:
	var player: Player = get_parent()
	for child in get_children():
		if child is Nozzle:
			child.color = player.target_color

func _on_shoot_timer_timeout() -> void:
	on_shoot.emit()
