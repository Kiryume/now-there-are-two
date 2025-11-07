class_name Enemy
extends CharacterBody2D


const SPEED = 20.0

var players: Array[Player]

func _ready():
	players = PlayerList.players

func _physics_process(delta: float) -> void:
	var player1 = players[0]
	var player2 = players[1]
	var closestPlayerPosition: Vector2
	if player1.position.distance_to(position) < player2.position.distance_to(position):
		closestPlayerPosition = player1.position
	else:
		closestPlayerPosition = player2.position
	var direction :Vector2= closestPlayerPosition - position
	direction = direction.normalized()
	velocity = direction * SPEED

	move_and_slide()
