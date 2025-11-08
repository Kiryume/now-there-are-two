class_name Hitbox
extends Area2D

@export var damage_profile: DamageResource

func _ready():
	add_to_group("hitbox")
