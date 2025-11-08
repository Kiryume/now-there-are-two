extends Camera2D

@export var move_speed := 30

@onready var bgoffset: ColorRect = $"../Background/BackgroundShader"

func get_camera_visible_rect() -> Rect2:
	var viewport := get_viewport()
	if not viewport:
		return Rect2()

	var viewport_size := viewport.get_visible_rect().size
	var camera_position := position
	var camera_zoom := zoom

	var world_width := viewport_size.x / camera_zoom.x
	var world_height := viewport_size.y / camera_zoom.y

	var half_size := Vector2(world_width, world_height) / 2.0
	var top_left := camera_position - half_size

	return Rect2(top_left, Vector2(world_width, world_height))
	
func _physics_process(delta):
	var targets: Array[Player] = PlayerList.players
	if not targets: return
	var p := Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed * delta)
	var rect := get_camera_visible_rect()
	bgoffset.material.set("shader_parameter/offset", Vector2(position.x / rect.size.x, position.y / rect.size.y))
