extends Upgrade

# We don't seem to use the player variable, but it's fine to keep
@onready var player: Player = get_parent().get_parent().owner

# Get a reference to the ColorRect node
@onready var color_rect: ColorRect = $ColorRect

func enable() -> void:
	print("Attaching and setting up shockwave")
	var canvas = CanvasLayer.new()
	add_child(canvas)
	color_rect.get_parent().remove_child(color_rect)
	canvas.add_child(color_rect)
	color_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	PlayerList.players_collided.connect(shock_wave)

func shock_wave():
	if not $Timer.is_stopped():
		return
	var material = (color_rect.material as ShaderMaterial)

	if material == null:
		print("ERROR: No ShaderMaterial found on $ColorRect")
		return

	# Start the "progress" from 0.0
	material.set_shader_parameter("size", 0.0)
	
	var tween = create_tween()
	var target_progress = 0.5;
	var duration = 0.4
	
	tween.tween_property(
		material, 
		"shader_parameter/size", 
		target_progress, 
		duration
	).set_trans(Tween.TRANS_QUART)
	target_progress = 0.0
	duration = 0.2
	tween.tween_property(
		material, 
		"shader_parameter/size", 
		target_progress, 
		duration
	)
	$Timer.start()
