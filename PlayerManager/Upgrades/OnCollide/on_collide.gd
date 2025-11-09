extends Upgrade

@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var hitbox_shape = $Hitbox/CollisionShape2D

var level = 0;

func enable() -> void:
	PlayerList.players_collided.connect(shock_wave)

func upgrade():
	$Hitbox.damage_multiplier *= 1.3
	level += 1

func can_be_chosen() -> bool:
	return level < 4

func shock_wave():
	if not $Timer.is_stopped():
		return
	$Timer.start()
	var material = (color_rect.material as ShaderMaterial)

	var circle_shape = hitbox_shape.shape as CircleShape2D
	var viewport_size = get_viewport().size
	
	var target_shader_size = 0.5
	var target_pixel_radius = target_shader_size * viewport_size.y * 0.5
	
	var expand_duration = 0.4
	var contract_duration = 0.2

	material.set_shader_parameter("size", 0.0)
	circle_shape.radius = 0.0
	hitbox_shape.set_deferred("disabled", false)

	var tween = create_tween()
	tween.set_parallel(false) 

	tween.tween_property(
		material, 
		"shader_parameter/size", 
		target_shader_size, 
		expand_duration
	).set_trans(Tween.TRANS_QUART)
	
	tween.parallel().tween_property(
		circle_shape,
		"radius",
		target_pixel_radius,
		expand_duration
	).set_trans(Tween.TRANS_QUART)
	
	tween.tween_property(
		material, 
		"shader_parameter/size", 
		0.0, 
		contract_duration
	)
	
	tween.parallel().tween_property(
		circle_shape,
		"radius",
		0.0,
		contract_duration
	)
	tween.tween_callback(
		func(): hitbox_shape.set_deferred("disabled", true)
	)
