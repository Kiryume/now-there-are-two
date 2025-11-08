class_name Enemy
extends CharacterBody2D

const SPEED = 20.0
# Adjust this value to make rotation faster or slower
const ROTATION_SPEED = 5.0

var players: Array[Player]

func _ready():
	players = PlayerList.players

func _physics_process(delta: float) -> void:
	var player1: Player = players[0]
	var player2: Player = players[1]
	var closest_player: Player

	if player1.position.distance_squared_to(position) < player2.position.distance_squared_to(position):
		closest_player = player1
	else:
		closest_player = player2
	var direction = closest_player.position - position
	if direction.length_squared() > 0.1:
		var target_angle = direction.angle() - 0.5
		rotation = lerp_angle(rotation, target_angle, delta * ROTATION_SPEED)
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
