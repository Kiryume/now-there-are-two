class_name Hitbox
extends Area2D

@export var damage_profile: DamageResource

var damage_multiplier: float = 1.0

func get_final_damage_profile() -> DamageResource:
	var final_profile: DamageResource = damage_profile.duplicate()
	final_profile.amount = damage_profile.amount * damage_multiplier
	return final_profile
