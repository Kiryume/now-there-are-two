extends Node

var players: Array[Player]

func set_players(new_players: Array[Player]):
	players = new_players

func get_center() -> Vector2:
	var p = Vector2.ZERO
	for target in players:
		p += target.position
	p /= players.size()
	return p
