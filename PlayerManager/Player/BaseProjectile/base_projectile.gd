class_name BaseProjectile
extends Hitbox

@onready
var text : ColorRect = $ColorRect

var direction: Vector2 = Vector2.UP
var lifetile_seconds = 5.0
var shooter: Node2D

var projectile_speed = 900.

func _on_area_entered(area: Area2D):
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	queue_free()

func set_direction(new_direction: Vector2):
	if new_direction == Vector2.ZERO:
		direction = Vector2.UP
	else:
		direction = new_direction.normalized()

func _physics_process(delta: float) -> void:
	position += transform.x * projectile_speed * delta
	lifetile_seconds -= delta
	if lifetile_seconds <= 0:
		queue_free()
