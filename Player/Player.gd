extends CharacterBody2D
class_name Player

@export
var speed := 300.

@export
var player_select := 1


@onready
var text : ColorRect = $ColorRect

func _ready():
	if player_select == 1:
		text.color = Color.RED
	else:
		text.color = Color.BLUE

const MAX_COLLISION_COUNT = 10

func take_collision_dmg(enemy: Enemy):
	pass

func _physics_process(delta: float) -> void:
	# --- 1. Get input direction ---
	var prefix = "p" + str(player_select)
	var p1x := Input.get_axis(prefix + "_move_left", prefix + "_move_right")
	var p1y := Input.get_axis(prefix + "_move_up", prefix + "_move_down")

	# --- 2. Normalize the direction vector (FIX 2) ---
	# This ensures you don't move faster diagonally.
	var input_direction = Vector2(p1x, p1y).normalized()

	# --- Set velocity using a REASONABLE speed (FIX 1) ---
	# 'speed' is pixels-per-second. 300 is a normal value.
	velocity = input_direction * speed 
	
	# --- 3. Move and check for ONE collision (FIX 3) ---
	var collision = move_and_collide(velocity * delta)
	
	# If a collision happened, 'collision' will not be null.
	if collision:
		# Check what we hit
		var collider = collision.get_collider()
		if collider is Enemy:
			take_collision_dmg(collider)

		# Optional: If you want to bounce, you could do this:
		# velocity = velocity.bounce(collision.get_normal())
