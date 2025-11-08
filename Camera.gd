extends Camera2D

@export var move_speed := 30 # camera position lerp speed
#@export var zoom_speed := 3.0  # camera zoom lerp speed
#@export var min_zoom := 1.0  # camera won't zoom closer than this
#@export var max_zoom := 1.0  # camera won't zoom farther than this
#@export var margin := Vector2(40, 20)  # include some buffer area around targets

#@onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	var targets := PlayerList.players
	if not targets: return
	var p := Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed * delta)

	#var r = Rect2(position, Vector2.ONE)
	#for target in targets:
		#r = r.expand(target.position)
	#r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)

	#var z
	#if r.size.x > r.size.y * screen_size.aspect():
		#z = 1 / clamp(r.size.x / screen_size.x, max_zoom, min_zoom)
	#else:
		#z = 1 / clamp(r.size.y / screen_size.y, max_zoom, min_zoom)
#
	#zoom = lerp(zoom, Vector2.ONE * z, zoom_speed * delta)
