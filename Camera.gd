extends Camera2D
class_name MainCamera

@export var move_speed := 30

@onready var bgoffset: ColorRect = $"../Background/BackgroundShader"

func get_camera_visible_rect() -> Rect2:
	var viewport := get_viewport()
	if not viewport:
		return Rect2()

	var viewport_size := viewport.get_visible_rect().size

	var world_width := viewport_size.x / zoom.x
	var world_height := viewport_size.y / zoom.y

	var half_size := Vector2(world_width, world_height) / 2.0
	var top_left := position - half_size

	return Rect2(top_left, Vector2(world_width, world_height))
	
func _physics_process(delta):
	var p = PlayerList.get_center()
	position = lerp(position, p, move_speed * delta)
	var rect := get_camera_visible_rect()
	bgoffset.material.set("shader_parameter/offset", Vector2(position.x / rect.size.x, position.y / rect.size.y))
