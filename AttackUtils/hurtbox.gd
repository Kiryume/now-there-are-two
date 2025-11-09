class_name Hurtbox
extends Area2D

signal hurt(damage_profile: DamageResource)

var lingering_hitboxes = {}

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D):
	if area is Hitbox:
		var profile = area.damage_profile
		if not profile:
			return

		if profile.damage_type == DamageResource.DamageType.Tick:
			lingering_hitboxes[area] = profile.tick_rate
			emit_signal("hurt", profile)
		else:
			emit_signal("hurt", profile)

func _on_area_exited(area: Area2D):
	if lingering_hitboxes.has(area):
		lingering_hitboxes.erase(area)

func _physics_process(delta: float):
	for hitbox in lingering_hitboxes.keys():
		if not is_instance_valid(hitbox):
			lingering_hitboxes.erase(hitbox)
			continue
		if not hitbox in lingering_hitboxes:
			continue
		lingering_hitboxes[hitbox] -= delta
		
		if lingering_hitboxes[hitbox] <= 0:
			var profile = hitbox.damage_profile
			emit_signal("hurt", profile)
			lingering_hitboxes[hitbox] = profile.tick_rate
