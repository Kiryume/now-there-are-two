class_name Hurtbox
extends Area2D

signal hurt(damage_profile: DamageResource)

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D):
	if area is Hitbox:
		var profile = area.damage_profile
		if profile:
			hurt.emit(profile)
