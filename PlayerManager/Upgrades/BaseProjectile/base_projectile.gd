class_name BaseProjectile
extends Area2D

@onready
var text : ColorRect = $ColorRect

var direction: Vector2 = Vector2.UP
var lifetile_seconds = 5.0
var shooter: Node2D

const PROJECTILE_SPEED = 900.

func get_base_dmg() -> float:
	return 10.

func set_direction(new_direction: Vector2):
	if new_direction == Vector2.ZERO:
		direction = Vector2.UP
	else:
		direction = new_direction.normalized()

func _physics_process(delta: float) -> void:
	position += transform.x * PROJECTILE_SPEED * delta
	lifetile_seconds -= delta
	if lifetile_seconds <= 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player or body is Enemy:
		body.on_projectile_collision(self)
	queue_free()
