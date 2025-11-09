class_name Enemy
extends CharacterBody2D

var players: Array[Player]
@export var max_health = 10.
@export var health = max_health
@export var speed = 90.
@export var rotation_speed = 5.

var color = Color.YELLOW*1.15

@onready var rect: ColorRect = $ColorRect

func update_color():
	var new_color = color
	new_color.s *= health / max_health
	rect.color = new_color

func take_dmg(dmg: float):
	health -= dmg
	update_color()
	if health <= 0 && not is_queued_for_deletion():
		die()

func die():
	queue_free()
	
func get_closest_player() -> Player:
	var player1: Player = players[0]
	var player2: Player = players[1]

	if player1.position.distance_squared_to(position) < player2.position.distance_squared_to(position):
		return player1
	else:
		return player2

func _ready():
	players = PlayerList.players
	update_color()

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
	
