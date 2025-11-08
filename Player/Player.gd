extends CharacterBody2D
class_name Player

@export
var speed := 500.

@export
var player_select := "left"


@onready
var text : ColorRect = $Texture

@onready
var muzzle_text : ColorRect = $Bullets2/MuzzleTexture

var target_color: Color

func _ready():
	if player_select == "left":
		target_color = Color.DEEP_PINK
	else:
		target_color = Color.DEEP_SKY_BLUE

	text.color = target_color
	muzzle_text.color = target_color

const MAX_COLLISION_COUNT = 10

func take_collision_dmg(enemy: Enemy):
	pass

func _physics_process(_delta: float) -> void:
	var prefix = player_select
	var p1x := Input.get_axis(prefix + "_move_left", prefix + "_move_right")
	var p1y := Input.get_axis(prefix + "_move_up", prefix + "_move_down")
	
	var input_direction = Vector2(p1x, p1y).normalized()
	
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		rotation = input_direction.angle()
	
	if input_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	
	move_and_slide()
