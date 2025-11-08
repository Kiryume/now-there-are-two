class_name Enemy
extends CharacterBody2D

var players: Array[Player]
@export var health = 10.
@export var speed = 90.
@export var rotation_speed = 5.

func get_player_collision_dmg() -> float:
	return 5.
	
func take_dmg(dmg: float):
	health -= dmg
	if health <= 0:
		die()
		
func die():
	queue_free()
	
func on_projectile_collision(projectile: BaseProjectile):
	if projectile.owner is Enemy: return
	var dmg = projectile.get_base_dmg()
	take_dmg(dmg)

func get_closest_player() -> Player:
	var player1: Player = players[0]
	var player2: Player = players[1]

	if player1.position.distance_squared_to(position) < player2.position.distance_squared_to(position):
		return player1
	else:
		return player2

func _ready():
	players = PlayerList.players
	$ColorRect.color = Color.YELLOW*1.15

func move_to_nearest_player(delta: float):
	var closest_player := get_closest_player()
	var direction = closest_player.position - position
	if direction.length() > 80.:
		var target_angle = direction.angle() - 0.5
		rotation = lerp_angle(rotation, target_angle, delta * rotation_speed)
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
