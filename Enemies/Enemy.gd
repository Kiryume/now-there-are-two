class_name Enemy
extends CharacterBody2D

var players: Array[Player]
@export var max_health = 10.
@export var health = max_health
@export var speed = 90.
@export var rotation_speed = 5.
@export var target_level = 1.

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
		UpgradeDB.total_enemies += 1
		die()

func die():
	queue_free()
	
func get_closest_player() -> Player:
	var closest: Player
	for player in players:
		if not player.visible:
			continue
		if not closest:
			closest = player
		if player.position.distance_squared_to(position) < closest.position.distance_squared_to(position):
			closest = player
	return closest

func _ready():
	players = PlayerList.players
	update_color()

func move_to_nearest_player(delta: float):
	var closest_player := get_closest_player()
	if not closest_player:
		return
	var direction = closest_player.position - position
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation, target_angle, delta * rotation_speed)
	velocity = direction.normalized() * speed
	move_and_slide()
	
