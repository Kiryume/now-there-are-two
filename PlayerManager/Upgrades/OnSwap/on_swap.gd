extends Upgrade

@onready var segment_shape: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var line_drawer: Line2D = $Line2D
@onready var timer: Timer = $Timer
@onready var player_manager: Node2D = get_parent().get_parent().owner.owner

@export var laser_duration: float = .2

func enable() -> void:
	print("Enabled")

	if get_parent() != player_manager:
		get_parent().remove_child(self)
		player_manager.add_child(self)
	segment_shape.disabled = true
	line_drawer.visible = false
	
	timer.wait_time = laser_duration
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	
	PlayerList.players_swapped.connect(laser_swap)


func laser_swap(pos1: Vector2, pos2: Vector2):
	if !timer.is_stopped():
		return

	var local_pos1 = player_manager.to_local(pos1)
	var local_pos2 = player_manager.to_local(pos2)

	line_drawer.clear_points()
	line_drawer.add_point(local_pos1)
	line_drawer.add_point(local_pos2)
	line_drawer.width = 5.0
	var color_start = Color.AQUA * 0.4
	var color_peak = Color.AQUA * 1.8
	var color_end = Color.AQUA * 0.0 # Fully transparent

	line_drawer.default_color = color_start
	line_drawer.visible = true

	if segment_shape.shape is SegmentShape2D:
		segment_shape.shape.a = local_pos1
		segment_shape.shape.b = local_pos2
	else:
		print("Error: segment_shape's shape is not a SegmentShape2D!")
		return

	segment_shape.disabled = false
	var tween = create_tween()
	tween.set_parallel(false) # This ensures the animations run in sequence
	
	var ratio_in = 0.13
	var ratio_out = 0.7
	var total_ratio_parts = ratio_in + ratio_out # This is 0.83
	
	# This calculates the duration for each part based on its ratio of the whole
	var duration_in = laser_duration * (ratio_in / total_ratio_parts)   # Approx 15.7% of total time
	var duration_out = laser_duration * (ratio_out / total_ratio_parts) # Approx 84.3% of total time
	
	# 4. Add the animations to the tween sequence
	
	# Part 1: Animate from start to peak (FAST)
	# EASE_OUT means it starts fast and slows down as it hits the peak
	tween.tween_property(line_drawer, "default_color", color_peak, duration_in) \
		 .set_trans(Tween.TRANS_SINE) \
		 .set_ease(Tween.EASE_OUT)
		 
	# Part 2: Animate from peak to end (SLOW)
	# EASE_IN means it starts fading slowly and then accelerates to invisible
	tween.tween_property(line_drawer, "default_color", color_end, duration_out) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)
	
	# --- MODIFICATIONS END HERE ---
	
	timer.start()


func _on_timer_timeout():
	segment_shape.disabled = true
	line_drawer.visible = false
	line_drawer.clear_points()
