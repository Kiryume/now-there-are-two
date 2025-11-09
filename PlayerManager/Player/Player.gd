extends CharacterBody2D
class_name Player

const speed := 250.

@export
var player_select := "left"

@export
var color_lerp_speed := 5.0

@onready
var text : ColorRect = $Texture

@onready
var muzzle_text : ColorRect = $WeaponController/MainNozzle/MuzzleTexture

@onready
var coin_pickup = $CoinPickup

var target_color: Color

const MAX_COLLISION_COUNT = 10

func take_collision_dmg(enemy: Enemy):
	pass
	
func on_projectile_collision(projectile: BaseProjectile):
	pass


func _process(delta: float) -> void:
	if player_select == "left":
		target_color = Color.DEEP_PINK * 1.15
	else:
		target_color = Color.DEEP_SKY_BLUE * 1.15
	text.color = text.color.lerp(target_color, delta * color_lerp_speed)
	muzzle_text.color = muzzle_text.color.lerp(target_color, delta * color_lerp_speed)


func _physics_process(_delta: float) -> void:
	var prefix = player_select
	var p1x := Input.get_axis(prefix + "_move_left", prefix + "_move_right")
	var p1y := Input.get_axis(prefix + "_move_up", prefix + "_move_down")
	
	var input_direction = Vector2(p1x, p1y).min(Vector2(p1x, p1y).normalized())
	
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		rotation = input_direction.angle()
	
	if input_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider() 
		if collider is Enemy:
			take_collision_dmg(collider)


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area is Drop:
		UpgradeDB.gain_xp(area.xp_value)
		area.queue_free()
		coin_pickup.play()


func _on_other_collide_check_area_entered(area: Area2D) -> void:
	PlayerList.players_collided.emit()
